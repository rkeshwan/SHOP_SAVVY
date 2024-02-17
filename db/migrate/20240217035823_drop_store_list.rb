class DropStoreList < ActiveRecord::Migration[7.0]
  def change
    remove_reference :grocery_lists, :store_list, index: true, foreign_key: true
    drop_table :store_lists
  end
end
