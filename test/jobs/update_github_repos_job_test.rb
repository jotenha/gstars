require "test_helper"

class UpdateGithubReposJobTest < ActiveJob::TestCase
  test "perform method enqueues GithubJob for each user" do
    user1 = User.create(name: "user1")
    user2 = User.create(name: "user2")

    assert_enqueued_jobs 2, only: GithubJob do
      UpdateGithubReposJob.perform_now
    end
  end
end
