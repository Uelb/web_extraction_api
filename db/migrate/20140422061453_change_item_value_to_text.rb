class ChangeItemValueToText < ActiveRecord::Migration
  def change
    change_column :items, :value, :text
  end
end
