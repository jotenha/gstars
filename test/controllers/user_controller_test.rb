require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get get_users_path
    assert_response :success
    assert_equal response.content_type, 'application/json'
    assert_not_empty response.body
  end

  test "should get user" do
    username = 'test_user'
    get get_user_path(username: username)
    assert_response :success
    assert_equal response.content_type, 'application/json'
    assert_not_empty response.body
  end

  test "should return not found for non-existent user" do
    username = 'non_existent_user'
    get get_user_path(username: username)
    assert_response :not_found
    assert_equal response.content_type, 'application/json'
    assert_equal response.body, { message: "User not found" }.to_json
  end
  test "should remove user" do
    username = 'test_user'
    assert_enqueued_with(job: RemoveuserJob, args: [username]) do
      post remove_user_path(username: username)
    end
    assert_response :success
    assert_equal response.content_type, 'application/json'
    assert_equal response.body, { message: "Enqueued, user will be deleted soon" }.to_json
  end

  test "should return not found for non-existent user" do
  username = 'non_existent_user'
  assert_no_enqueued_jobs do
    post remove_user_path(username: username)
  end
  assert_response :not_found
  assert_equal response.content_type, 'application/json'
  assert_equal response.body, { message: "User not found" }.to_json
  end
end
