class Store < ApplicationRecord
  has_many :item_store
  has_many :item, through: :item_store

  validates :name, :address, presence: true
end
