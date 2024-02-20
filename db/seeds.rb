# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'

result = File.read(File.join(File.dirname(__FILE__),"all-products.json"))
JSON.parse(result).each do |item|
  p item["brand"]
  p item["name"]
  p item["price"]


Store.destroy_all

coles = { name: 'Coles', address: '7 Boundary St, Hawthorn' }
woolworths = { name: 'Woolworths', address: '56 Salamanca Rd, South Melbourne' }
organic_oasis = { name: 'Organic Oasis', address: '55 Soho St, Northcote' }
city_mart = { name: 'City Mart', address: '27 Trafalgar St, Richmond' }
bliss_foods = { name: 'Bliss Foods', address: '2 Frozen Alley, Cremorne' }

[coles, woolworths, organic_oasis, city_mart, bliss_foods].each do |attributes|
  store = Store.create!(attributes)

end
