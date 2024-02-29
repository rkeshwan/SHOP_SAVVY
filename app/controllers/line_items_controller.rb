class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def add_item
    @grocery_list = current_user.grocery_list # user's grocery list
    @line_item = LineItem.new(item_id: params[:id], quantity: 1, grocery_list: @grocery_list) # key value pair, hard-coded quantity
    @line_item.save
    redirect_to search_path # stay on the same page
  end

  def adjust_item
    @line_item = LineItem.find(params[:id])
    @line_item.update(line_item_params)
    @line_item.save
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to search_path
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
