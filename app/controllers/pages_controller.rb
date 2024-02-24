class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    @items = Item.first(20)
    @grocery_lists = GroceryList.find_by(user: current_user)
    @line_items = GroceryList.find_by(user: current_user).line_items
  end

  def dashboard
  end
end
