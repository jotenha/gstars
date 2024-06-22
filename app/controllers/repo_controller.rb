class RepoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]



  def create
    username = params[:username]
    Rails.logger.info "Username on controller: #{username}"
    #GithubJob.perform_async(username)
    GithubJob.perform_later(username)
    render json: { message: "Job enqueued" }, status: :ok
  end
end
