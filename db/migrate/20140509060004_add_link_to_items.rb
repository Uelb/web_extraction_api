class AddLinkToItems < ActiveRecord::Migration
  def change
    add_column :items, :link, :string
  end
end
