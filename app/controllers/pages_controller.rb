class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    @items = Item.all
  end

  def dashboard
  end
end
