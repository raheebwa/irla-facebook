class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, unique: true
      t.text :body

      t.timestamps
    end
  end
end
