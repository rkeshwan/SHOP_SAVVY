class CreateStoreLists < ActiveRecord::Migration[7.0]
  def change
    create_table :store_lists do |t|
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
