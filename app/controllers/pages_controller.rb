class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    if params[:query].present?
      @items = Item.search_by_name_and_category(params[:query])
    else
      @items = Item.where("id % 7 = 0").offset(4).limit(5).shuffle
    end

    @line_items = GroceryList.find_by(user: current_user).line_items
  end

  def index
  end

  def dashboard

    #iterate here
    # raise
    @grocery_list = GroceryList.find_by(user: current_user)
    @line_items = @grocery_list.line_items.name
    # @items = Item.search_by_name_and_category(name: @line_items)
    # Item_id hash
    item_id_hash = {}
    counter = 0
    @grocery_list.items.each do |item|
      id = Item.find_by_id(item).id
      # check each item name in our db, find all the db entries attached to it & find the most expensive price attached to that item.
      items = Item.where(name: item.name)
      # highest = items.select { |item|  }
      highest = items.max_by(&:price)
      # Take out item price & subtract that from most expensive item found.
      difference = (highest.price - item.price)
      # Put this item id & price diff. into our item_hash as a key/value pair
      item_id_hash[id] = { price: difference }
    end
    @grocery_list.line_items.each do |item|
    # check the hash already created for item_id & once found it'll take the value of the key of the ID & will add to the counter x amount from qty from line_item
      if item_id_hash[item.item_id]
        item_difference = item_id_hash[item.item_id][:price] * item.quantity
        counter += item_difference
      end
    # as a result counter variable should total full savings
    end
    # @counter goes on the view page
  


    @store_hash = cart
    @grocery_store = @store_hash.keys.first
  end

  def cart_page
    @store_hash = cart
    render :cart
  end

  private


  def cart
    @grocery_list = GroceryList.find_by(user: current_user)
    @line_items = @grocery_list.line_items
    @store_hash = {}

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

    @store_hash
  end
end
