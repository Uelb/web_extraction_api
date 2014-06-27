class AddBordersToExtractions < ActiveRecord::Migration
  def change
    remove_column :extractions, :border_width
    add_column :extractions, :border_horizontal_width, :float
    add_column :extractions, :border_vertical_width, :float
  end
end
