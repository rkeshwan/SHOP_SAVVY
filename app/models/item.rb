class Item < ApplicationRecord
  has_many :item_store
  has_many :grocery_lists, through: :line_item
  has_many :stores, through: :item_store

  validates :name, :price, presence: true
end
