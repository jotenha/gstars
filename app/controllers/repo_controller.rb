# app/controllers/RepoController.rb
class RepoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

#require_dependency 'gh_get_service'

  def create
    username = params[:username]
    Rails.logger.info "Username: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos

    if response.success?
      repositories = JSON.parse(response.body).map do |repo|
        {
          name: repo['name'],
          stars: repo['stargazers_count']
        }
      end
      render json: repositories, status: :ok
    else
      render json: { error: "Failed to fetch repositories for user: #{username}" }, status: :unprocessable_entity
    end
  end
end

class GithubService

  include HTTParty

  base_uri 'https://api.github.com'

  def initialize(username)
    @username = username
  end

  def get_repos
    self.class.get("/users/#{@username}/repos")
  end
end
