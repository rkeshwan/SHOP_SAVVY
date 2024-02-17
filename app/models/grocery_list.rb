class GroceryList < ApplicationRecord
  belongs_to :line_item
  belongs_to :user
  has_many :items, through: :line_item
end
