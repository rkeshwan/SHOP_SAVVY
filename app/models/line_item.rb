class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :grocery_list
  validates :quantity, presence: true
end
