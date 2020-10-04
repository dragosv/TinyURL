require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test "valid url" do
    token = Token.new
    token.url = 'http://www.google.com'
    token.token = 'test'
    token.save!

    token = Token.find_by :url => 'http://www.google.com'
    assert_not_nil token
  end

  test "empty url should fail" do
    token = Token.new

    assert_raise { token.save! }
  end

  test "duplicate url should fail" do
    token = Token.new
    token.url = 'http://www.google.com'
    token.token = 'test'
    token.save!

    token = Token.new
    token.url = 'http://www.google.com'
    token.token = 'test1'
    assert_raise { token.save! }
  end

  test "invalid url should fail" do
    token = Token.new
    token.url = 'test://www.google.com'
    token.token = 'test'

    assert_raise { token.save! }
  end

  test "duplicate token should fail" do
    token = Token.new
    token.url = 'http://www.google.com'
    token.token = 'test'
    token.save!

    token = Token.new
    token.url = 'http://www.test.com'
    token.token = 'test'
    assert_raise { token.save! }
  end
end