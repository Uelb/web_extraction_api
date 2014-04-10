class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :value
      t.references :website

      t.timestamps
    end
  end
end
