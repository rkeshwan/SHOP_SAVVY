class LineItem < ApplicationRecord
  belongs_to :item

  validates :quantity, presence: true
end
