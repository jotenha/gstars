class UpdateGithubReposJob < ApplicationJob
  queue_as :default

  #github probably has a rate limit but just for the ideia of the code

  def perform
    User.find_each do |user|
      GithubJob.perform_later(user.name)
    end
  end
end
