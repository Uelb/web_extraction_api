class DeleteUserIdFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :user_id
  end
end
