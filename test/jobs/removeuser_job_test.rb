require "test_helper"

class RemoveuserJobTest < ActiveJob::TestCase
  test "removes user and their repos" do
    #creating a stub user and repos
    username = "test_user"
    user = User.create(name: username)
    repo1 = Repo.create(user: user)
    repo2 = Repo.create(user: user)

    RemoveuserJob.perform_now(username)

    assert_nil User.find_by(name: username)
    assert_empty Repo.where(user: user)
  end
end
