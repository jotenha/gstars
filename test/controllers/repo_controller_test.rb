require "test_helper"

class RepoControllerTest < ActionDispatch::IntegrationTest
test "should create job and return success" do
  post repo_create_url, params: { username: "test_user" }
  assert_response :success
  assert_equal "Job enqueued", response.parsed_body["message"]
end
