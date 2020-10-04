require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  test "valid visit" do
    token = Token.new
    token.url = 'http://www.google.com'
    token.token = 'test'
    token.save!

    visit = Visit.new
    visit.token = token
    visit.ip = '127.0.0.1'
    visit.save!
  end
end