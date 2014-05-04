class AddContainerToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :container, :boolean
  end
end
