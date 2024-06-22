class RemoveuserJob < ApplicationJob
  queue_as :default

  def perform(username)
    user = User.find_by(name: username)
    if user
      user.repos.destroy_all
      user.destroy
    end
  end
end
