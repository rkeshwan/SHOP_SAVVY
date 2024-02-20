class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    @line_items = LineItem.all
  end

  def dashboard
    @items = Item.all
  end

end
