class ChangeReferenceOfStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :website_id
    add_column :statistics, :extraction_id, :integer, index: true
  end
end
