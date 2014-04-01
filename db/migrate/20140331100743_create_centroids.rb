class CreateCentroids < ActiveRecord::Migration
  def change
    create_table :centroids do |t|
      t.float :color
      t.float :background_color
      t.float :width
      t.float :height
      t.float :text_decoration
      t.float :font_style
      t.float :left_alignment
      t.float :top_alignment
      t.float :z_index
      t.string :label
      t.references :website, index: true
      t.integer :level

      t.timestamps
    end
  end
end
