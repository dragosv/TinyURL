require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should create token" do
    post '/', params: { :url => 'https://www.google.com' }

    token = Token.find_by :url => 'https://www.google.com'
    assert_not_nil token
    assert_not_empty token.token
  end

  test "should not create invalid token" do
    post '/', params: { :url => '' }

    assert_equal "Validation failed: Url can't be blank, Url is invalid", flash[:alert]
  end

  test "should redirect valid token" do
    count = Visit.count

    token = Token.new
    token.url = 'https://www.google.com'
    token.token = 'test'
    token.save!

    get '/test'
    assert_redirected_to %r(\Ahttps://www.google.com)
    assert_equal count + 1, Visit.count
  end

  test "should not redirect invalid token" do
    get '/test'

    assert_response :missing
  end

  test "should get info valid token" do
    token = Token.new
    token.url = 'https://www.google.com'
    token.token = 'test'
    token.save!

    get '/test/info'
    assert_response :success
  end

  test "should get info invalid token" do
    get '/test/info'

    assert_response :missing
  end

end
