class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    if params[:query].present?
      @items = Item.all
      @items = @items.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @items = Item.first(5)
    end

    @grocery_lists = GroceryList.find_by(user: current_user)
    @line_items = GroceryList.find_by(user: current_user).line_items
  end

  def index
  end

  def dashboard
  end
end
