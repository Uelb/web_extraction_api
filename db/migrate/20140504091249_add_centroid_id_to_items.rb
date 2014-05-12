class AddCentroidIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :centroid, index: true
  end
end
