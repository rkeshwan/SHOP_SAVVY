class CreateItemStores < ActiveRecord::Migration[7.0]
  def change
    create_table :item_stores do |t|
      t.references :item, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
