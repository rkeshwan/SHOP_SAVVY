class AddGroceryListToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_items, :grocery_list, index: true
  end
end
