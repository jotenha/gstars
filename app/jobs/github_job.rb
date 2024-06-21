class GithubJob < ApplicationJob
  #taks priority?
  queue_as :default

  def perform(username)
    Rails.logger.info "Username on job: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos
    if response.success?
      user = User.find_or_create_by(name: username)
      repositories = JSON.parse(response.body).map do |repo|
        #probably check if the repo is already there
        user.repos.create(name: repo['name'], stars: repo['stargazers_count'])
      end
    #render json: { message: "User and repositories saved successfully" }, status: :ok
    end
  end
end
