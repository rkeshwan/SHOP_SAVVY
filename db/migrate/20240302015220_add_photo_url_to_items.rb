class AddPhotoUrlToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :photo_url, :string
  end
end
