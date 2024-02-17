class LineItem < ApplicationRecord
  belongs_to :item
  has_many :grocery_lists

  validates :quantity, presence: true
end
