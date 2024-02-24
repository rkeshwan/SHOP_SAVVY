class RemoveLineItemFromGroceryList < ActiveRecord::Migration[7.0]
  def change
    remove_reference :grocery_lists, :line_item, index: true, foreign_key: true
  end
end
