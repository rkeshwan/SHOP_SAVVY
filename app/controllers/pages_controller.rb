class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    if params[:query].present?
      @items = Item.search_by_name_and_category(params[:query])
    else
      @items = Item.first(5)
    end

    @line_items = GroceryList.find_by(user: current_user).line_items
  end

  def index
  end

  def dashboard
  end

  def cart
    @grocery_list = GroceryList.find_by(user: current_user)
    @items = @grocery_list.items
# store_hash = {}
# // The stores that are attached via grocery list/items/then stores
# @stores.each |store|
# if store_hash[:store]
# store_hash[:store] += store.item.amount
# else
# store_hash[:store] = store.item.amount
# End
  end

end
