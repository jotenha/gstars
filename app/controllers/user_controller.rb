class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:get_users]

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
end
