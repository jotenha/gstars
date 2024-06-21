class RenameUsersIdToUserIdInRepos < ActiveRecord::Migration[7.1]
  def change
    rename_column :repos, :users_id, :user_id
  end
end
