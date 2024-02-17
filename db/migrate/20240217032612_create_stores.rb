class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :rating
      t.string :address

      t.timestamps
    end
  end
end
