class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
  end

  def cart
    @grocery_list = GroceryList.find_by(user: current_user)
    @line_items = @grocery_list.line_items
    @store_hash = {}
    # {
    #   "coles": {
    #     totalprice: 1,
    #     items: []
    #   }
    # }
    @line_items.each do |line|
      key = line.item.stores.first.name
      if @store_hash[key]
        @store_hash[key][:totalprice] += (line.item.price * line.quantity) /100.0
        @store_hash[key][:items] << line
      else
        @store_hash[key] = {
          totalprice: (line.item.price * line.quantity) /100.0,
          items: [line]
        }
        # @store_hash[key][:totalprice] = (line.item.price * line.quantity) /100.0
        # @store_hash[key][:item] = [line]
      end
    end
  end
end
