require "test_helper"

class RepoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repo_index_url
    assert_response :success
  end
end
