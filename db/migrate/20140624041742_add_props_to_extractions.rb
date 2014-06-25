class AddPropsToExtractions < ActiveRecord::Migration
  def change
    add_column :extractions, :padding_l_r, :float
    add_column :extractions, :padding_t_b, :float
    add_column :extractions, :border_width, :float
    Extraction.update_all padding_l_r: 1
    Extraction.update_all padding_t_b: 1
    Extraction.update_all border_width: 1
  end
end
