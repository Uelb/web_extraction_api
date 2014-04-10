class AddUserIdToWebsites < ActiveRecord::Migration
  def change
    add_reference :websites, :user_id, index: true
  end
end
