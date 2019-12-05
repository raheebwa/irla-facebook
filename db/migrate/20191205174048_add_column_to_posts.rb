class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :image_path, :string, null: true
  end
end
