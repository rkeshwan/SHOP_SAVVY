class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
    @items = Item.all
    if params[:query].present?
      @items = @items.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def index
  end

end
