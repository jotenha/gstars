class GithubJob < ApplicationJob
  queue_as :default

  def perform(username)
    Rails.logger.info "Username on job: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos

    if response.success?
      user = User.find_or_create_by(name: username)
      repos = JSON.parse(response.body)

      existing_repos = user.repos.where(name: repos.map { |repo| repo['name'] }).index_by(&:name)

      repos.each do |repo|
        existing_repo = existing_repos[repo['name']]
        if existing_repo
          # Update stars count if it has changed
          if existing_repo.stars != repo['stargazers_count']
            existing_repo.update(stars: repo['stargazers_count'])
          end
        else
          user.repos.create(name: repo['name'], stars: repo['stargazers_count'])
        end
      end
    end
  end
end
