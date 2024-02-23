# This file should contain all the record creation needed to seed the database with its default values.

# User database
User.destroy_all

anna = { email: 'anna@gmail.com', password: 'password' }
jack = { email: 'jack@gmail.com', password: 'password' }
edith = { email: 'edith@gmail.com', password: 'password' }

[anna, jack, edith].each do |attributes|
  user = User.create!(attributes)
end

# Item database
require 'json'

result = File.read(File.join(File.dirname(__FILE__),"all-products.json"))
JSON.parse(result).each do |item|
  Item.create!(name: item["name"], category: item["categoryIds"].first, price: item["price"], image: item("imagePath"))
end

# Store database
Store.destroy_all

coles = { name: 'Coles', address: '7 Boundary St, Hawthorn' }
woolworths = { name: 'Woolworths', address: '56 Salamanca Rd, South Melbourne' }
organic_oasis = { name: 'Organic Oasis', address: '55 Soho St, Northcote' }
city_mart = { name: 'City Mart', address: '27 Trafalgar St, Richmond' }
bliss_foods = { name: 'Bliss Foods', address: '2 Frozen Alley, Cremorne' }

[coles, woolworths, organic_oasis, city_mart, bliss_foods].each do |attributes|
  store = Store.create!(attributes)
end
