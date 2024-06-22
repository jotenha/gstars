class UpdateGithubReposJob < ApplicationJob
  queue_as :default

  #github probably has a rate limit but just for the ideia of "keeping track"

  def perform
    User.find_each do |user|
      GithubJob.perform_later(user.name)
      Rails.logger.info "Finished updating user #{user.name}"
    end
    Rails.logger.info "Finished UpdateGithubReposJob at #{Time.current}"
  end
end
