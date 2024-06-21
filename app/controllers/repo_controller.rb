class RepoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]


  def create
    username = params[:username]
    Rails.logger.info "Username: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos

    if response.success?
      user = User.find_or_create_by(name: username)
      repositories = JSON.parse(response.body).map do |repo|
        user.repos.create(name: repo['name'], stars: repo['stargazers_count'])
      end
    render json: { message: "User and repositories saved successfully" }, status: :ok
    end
  end
end
