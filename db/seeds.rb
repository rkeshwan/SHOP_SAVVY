# This file should contain all the record creation needed to seed the database with its default values.
require 'pry'
require 'json'
require "open-uri"
require "pry-byebug"

puts "Clearing db"
LineItem.destroy_all
GroceryList.destroy_all
Store.destroy_all
User.destroy_all
Item.destroy_all

# User database
anna = { email: 'anna@gmail.com', password: 'password' }
jack = { email: 'jack@gmail.com', password: 'password' }
edith = { email: 'edith@gmail.com', password: 'password' }

puts "Creating users"
[anna, jack, edith].each do |attributes|
  User.create!(attributes)
end

user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
# Item database
puts "Creating items"
result = File.read(File.join(File.dirname(__FILE__), "all-products.json"))
JSON.parse(result).each do |item|
  # file = URI.open(item["imagePath"]) # add col. via migration for photo URL & delete this line
  response = HTTParty.get(item["imagePath"], headers: {"User-Agent" => user_agent})



  # puts response.body
  image_data = response.body if response.code == 200


  base_directory = Rails.root.join('tmp', 'images')

  # Ensure the directory exists
  Dir.mkdir(base_directory) unless Dir.exist?(base_directory)

  # Generate a unique file name for the image
  file_name = "#{item["name"]}.jpg"

  # Combine the base directory and file name to get the full file path
  file_path = File.join(base_directory, file_name)

  # Now you have a file_path that you can use to save the image
  # For example:
  File.open(file_path, "wb") do |file|
    # Assuming 'image_data' contains the binary data of the image
    file.write(image_data)
  end

  file = File.open(file_path, 'rb')

  # # file_path is now "/path/to/your/desired/location/<unique_id>.jpg"
  # # You can use this path with Cloudinary::Uploader.upload
  # uploaded_image = Cloudinary::Uploader.upload(file_path)

  # After uploading, you can delete the local file if you want

  item = Item.new(name: item["name"], category: item["categoryIds"].first, price: item["price"]) # photo_url = (item["imagePath"] - add as key value pair
  item.photo.attach(io: file, filename: "#{item.name}.jpg", content_type: "image/jpg") # remove line
  item.save

  file.close
  File.delete(file_path) if File.exist?(file_path)
end

# Store database
puts "Creating stores"
coles = { name: 'Coles', address: '7 Boundary St, Hawthorn' }
woolworths = { name: 'Woolworths', address: '56 Salamanca Rd, South Melbourne' }
organic_oasis = { name: 'Organic Oasis', address: '55 Soho St, Northcote' }
city_mart = { name: 'City Mart', address: '27 Trafalgar St, Richmond' }
bliss_foods = { name: 'Bliss Foods', address: '2 Frozen Alley, Cremorne' }

[coles, woolworths, organic_oasis, city_mart, bliss_foods].each do |attributes|
  Store.create!(attributes)
end

puts "Creating grocery lists"
User.all.each do |user|
  # Default grocery list - this will exist for the user when they log in to test it
  list = GroceryList.create!(user: user)
  Item.first(5).each do |line_item|
    # binding.pry
    puts "Creating 1 line item"
    LineItem.create!(quantity: 1, item: line_item, grocery_list: list)
  end
end
