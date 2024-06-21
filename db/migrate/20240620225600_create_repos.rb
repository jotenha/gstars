class CreateRepos < ActiveRecord::Migration[7.1]
  def change
    create_table :repos do |t|
      t.string :name
      t.float :stars
      t.references :user, foreign_key: true  # Adiciona o atributo user_id
      t.timestamps
    end
  end
end
