class RemoveWebsiteIdFromCentroids < ActiveRecord::Migration
  def change
    remove_column :centroids, :website_id, :integer
    remove_column :centroids, :label, :string
    add_column :centroids, :label_id, :integer
  end
end
