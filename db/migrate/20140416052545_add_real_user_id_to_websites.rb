class AddRealUserIdToWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :user_id_id
    add_reference :websites, :user, index: true
  end
end
