class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :value
      t.references :centroid, index: true

      t.timestamps
    end
  end
end
