class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :website, index: true
      t.integer :color, default: 0
      t.integer :background_color, default: 0
      t.integer :width, default: 0
      t.integer :height, default: 0
      t.integer :text_decoration, default: 0
      t.integer :font_style, default: 0
      t.integer :left_alignment, default: 0
      t.integer :top_alignment, default: 0
      t.integer :z_index, default: 0
      t.integer :padding_l_r, default: 0
      t.integer :padding_t_b, default: 0
      t.integer :border_horizontal_width, default: 0
      t.integer :border_vertical_width, default: 0

      t.timestamps
    end
  end
end
