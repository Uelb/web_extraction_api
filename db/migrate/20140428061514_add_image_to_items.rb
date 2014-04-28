class AddImageToItems < ActiveRecord::Migration
  def change
    add_column :items, :image, :boolean, default: false, null: false
  end
end
