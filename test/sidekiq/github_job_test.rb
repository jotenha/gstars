require 'test_helper'

class GithubJobTest < Minitest::Test
  def setup
    @username = 'test_user'
    @job = GithubJob.new
  end

  def test_perform
    # stub GithubService
    github_service = Minitest::Mock.new
    GithubService.stub(:new, github_service) do
      # stub response
      response = OpenStruct.new(success?: true, body: '[{"name": "repo1", "stargazers_count": 10}, {"name": "repo2", "stargazers_count": 20}]')
      github_service.expect(:get_repos, response)

      # stub User
      user = Minitest::Mock.new
      User.stub(:find_or_create_by, user) do
        # stub Repos
        repos = Minitest::Mock.new
        user.expect(:repos, repos)
        repos.expect(:create, nil, [{ name: 'repo1', stars: 10 }])
        repos.expect(:create, nil, [{ name: 'repo2', stars: 20 }])

        @job.perform(@username)
      end
    end
    assert_mock github_service
    assert_mock user
    assert_mock repos
  end
end
