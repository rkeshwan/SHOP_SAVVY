class Item < ApplicationRecord
  has_many :item_store
  has_many :grocery_lists, through: :line_item
  has_many :stores, through: :item_store
  has_one_attached :photo
  include PgSearch::Model

  pg_search_scope :search_by_name_and_category,
                  against: %i[name category],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :name, :price, presence: true
end
