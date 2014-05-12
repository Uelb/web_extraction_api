class ChangeDefaultOfContainerFromLabels < ActiveRecord::Migration
  def change
    change_column :labels, :container, :boolean, default: false
  end
end
