require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get get_users_path
    assert_response :success
    assert_equal response.content_type, 'application/json'
    assert_not_empty response.body
  end
