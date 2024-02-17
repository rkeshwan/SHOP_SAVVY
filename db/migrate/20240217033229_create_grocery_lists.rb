class CreateGroceryLists < ActiveRecord::Migration[7.0]
  def change
    create_table :grocery_lists do |t|
      t.integer :total_price
      t.references :line_item, null: false, foreign_key: true
      t.references :store_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
