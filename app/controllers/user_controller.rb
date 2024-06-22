class UserController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_users
    users = User.all.map do |user|
      { name: user.name, repos: user.repos.map{|repo| { name: repo.name, stars: repo.stars}}}
    end
    render json: users, status: :ok
  end

  def get_user
    username = params[:username]
    user = User.find_by(name: username)
    if user
      render json: { name: user.name, repos: user.repos.map{|repo| { name: repo.name, stars: repo.stars}}}, status: :ok
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end

  #could probably do more filtering, like get repos with stars > x
  #users with 10+ stars, etc

  #token checking should be done in a middleware or a before_action but for the sake of simplicity/visibility
  #I'm doing it here

  def remove
    username = params[:username]
    if request.headers['Admin-Token']
      token = request.headers['Admin-Token']
      if token == ENV['ADMIN_TOKEN']
        RemoveuserJob.perform_later(username)
        render json: { message: "Enqueued, user will be deleted soon" }, status: :ok
      else
        render json: { error: "Forbidden - Invalid token"}, status: :forbidden
      end
    else
      render json: { error: "Admin-Token header missing" }, status: :bad_request
    end
  end
end
