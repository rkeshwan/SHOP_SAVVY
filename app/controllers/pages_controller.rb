class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    # @items = sorting(Item.all)
    # Search
    if params[:query].present?
      records = Item.search_by_name_and_category(params[:query])
      @items = sorting(records)

    else
      records_shuffle = Item.where("id % 17 = 0").offset(4).limit(50).shuffle
      @items = sorting(records_shuffle)

    end
    # Grocerylist
    @line_items = GroceryList.find_by(user: 6).line_items
  end

  def sorting(records)
    if params[:sort_order] == "asc"
      return records.sort_by { |item| item[:price] }
    elsif params[:sort_order] == "desc"
      return records.sort_by { |item| -item[:price] }
    else
      return records
    end
  end

  def dashboard
    @grocery_list = GroceryList.find_by(user: 6)
    @line_items = @grocery_list.line_items
    @item_id_hash = {}
    @counter = 0

    @grocery_list.items.each do |item|
      # Find the ID of the current item
      id = Item.find_by_id(item).id
      # Find all items with the same name as the current item
      items = Item.where(name: item.name)
      # Find the item with the highest price among items with the same name
      highest_price = items.max_by(&:price)
      # Calculate the price difference between the highest priced item and the current item
      price_difference = (highest_price.price - item.price)
      # Store the item's ID, name, and price difference in @item_id_hash
      @item_id_hash[id] = { name: item.name, price: price_difference }
    end

    @grocery_list.line_items.each do |item|
      # Check if the item_id exists in @item_id_hash
      if @item_id_hash[item.item_id]
        # If it exists, calculate the total price difference for this item
        item_difference = @item_id_hash[item.item_id][:price] * item.quantity
        # Add the price difference to the counter
        @counter += item_difference
        # raise
      end
    end

    # Iterate over each line item again to update the quantity in @item_id_hash
    @line_items.each do |line_item|
      item_id = line_item.item_id
      quantity = line_item.quantity

      # If the item_id exists in the hash, update the quantity by adding the new quantity
      if @item_id_hash[item_id]
        # Ensure quantity is initialized to 0 if it's nil
        @item_id_hash[item_id][:quantity] ||= 0
        # Add the new quantity to the existing quantity
        @item_id_hash[item_id][:quantity] += quantity
      else
        item = Item.find(item_id)
        @item_id_hash[item_id] = { name: item.name, quantity: quantity }
      end
    end
    # raise

    @store_hash = cart
    @grocery_store = @store_hash.keys.first
  end

  def cart_page
    @store_hash = cart
    render :cart
  end

  def store
    @stores = Store.all
  end

  private

  def cart
    @grocery_list = GroceryList.find_by(user: 6)
    @line_items = @grocery_list.line_items
    @store_hash = {}
    @total_price = 0

    @line_items.each do |line|
      key = line.item.stores.first.name
      if @store_hash[key]
        @store_hash[key][:totalprice] += (line.item.price * line.quantity) / 100.0
        @store_hash[key][:items] << line
      else
        @store_hash[key] = {
          totalprice: (line.item.price * line.quantity) / 100.0,
          items: [line]
        }
      end
    end

    @store_hash.each do |_store, value|
      @total_price += value[:totalprice]
    end

    @store_hash
  end
end
