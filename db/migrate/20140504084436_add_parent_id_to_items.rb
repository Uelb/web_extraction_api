class AddParentIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :parent, index: true
  end
end
