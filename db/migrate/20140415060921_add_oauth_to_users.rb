class AddOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :text
    add_column :users, :provider, :string
    add_column :users, :provider_token, :string
  end
end
