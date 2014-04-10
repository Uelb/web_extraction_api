class RenameCentroidIdFromItems < ActiveRecord::Migration
  def change
    rename_column :items, :centroid_id, :label_id

  end
end
