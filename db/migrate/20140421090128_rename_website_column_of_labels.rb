class RenameWebsiteColumnOfLabels < ActiveRecord::Migration
  def change
    rename_column :labels, :website_id, :extraction_id
  end
end
