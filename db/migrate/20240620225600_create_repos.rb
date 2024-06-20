class CreateRepos < ActiveRecord::Migration[7.1]
  def change
    create_table :repos do |t|
      t.string :name
      t.float :stars

      t.timestamps
    end
  end
end
