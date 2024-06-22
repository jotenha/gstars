class GithubJob < ApplicationJob
  #taks priority?
  queue_as :default

  #in case of per-job backend
  #self.queue_adapter = :sidekiq

  def perform(username)
    Rails.logger.info "Username on job: #{username}"
    github_service = GithubService.new(username)
    response = github_service.get_repos
     if response.success?
          #if status is 200
          user = User.find_or_create_by(name: username)
          repositories = JSON.parse(response.body).map do |repo|
            #probably check if the repo is already there
            user.repos.create(name: repo['name'], stars: repo['stargazers_count'])
          end
        #status is 404, 422, etc
        else
          Rails.logger.error "Error on job: #{response.body.message}"
        end
end
end
