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

# User database
anna = { email: 'anna@gmail.com', password: 'password' }
jack = { email: 'jack@gmail.com', password: 'password' }
edith = { email: 'edith@gmail.com', password: 'password' }

puts "Creating users"
[anna, jack, edith].each do |attributes|
  User.create!(attributes)
end

# Item database
puts "Creating items"
result = File.read(File.join(File.dirname(__FILE__), "all-products.json"))
JSON.parse(result).each do |item|
  file = URI.open(item["imagePath"]) # add col. via migration for photo URL & delete this line
  item = Item.new(name: item["name"], category: item["categoryIds"].first, price: item["price"]) # photo_url = (item["imagePath"] - add as key value pair
  item.photo.attach(io: file, filename: "#{item.name}.jpg", content_type: "image/jpg") # remove line
  item.save
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
