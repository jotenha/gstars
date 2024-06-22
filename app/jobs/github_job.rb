class GithubJob < ApplicationJob
  queue_as :default

  def perform(username)
    Rails.logger.info "Username on job: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos
    if response.success?
      user = User.find_or_create_by(name: username)
      JSON.parse(response.body).each do |repo|
        existing_repo = user.repos.find_by(name: repo['name'])
        if existing_repo
          # Update stars count if it has changed
          #Rails.logger.info "Repo found: #{repo['name']}..trying to update!"
          if existing_repo.stars != repo['stargazers_count']
            existing_repo.update(stars: repo['stargazers_count'])
            #Rails.logger.info "Repo changed: #{repo['name']}..updated!"
          end
        else
          # Create a new repo if it doesn't exist
          user.repos.create(name: repo['name'], stars: repo['stargazers_count'])
        end
      end
    end
  end
end
