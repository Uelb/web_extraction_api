class AddBordersToCentroids < ActiveRecord::Migration
  def change
    remove_column :centroids, :border_width
    add_column :centroids, :border_horizontal_width, :float
    add_column :centroids, :border_vertical_width, :float
  end
end
