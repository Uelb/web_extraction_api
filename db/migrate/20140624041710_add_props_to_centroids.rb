class AddPropsToCentroids < ActiveRecord::Migration
  def change
    add_column :centroids, :padding_l_r, :float
    add_column :centroids, :padding_t_b, :float
    add_column :centroids, :border_width, :float
    Centroid.update_all padding_l_r: 1
    Centroid.update_all padding_t_b: 1
    Centroid.update_all border_width: 1
  end
end
