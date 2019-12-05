class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :post, foreign_key: true, null: true
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true, null: true

      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps
    end
  end
end
