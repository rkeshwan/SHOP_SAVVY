class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:adjust_item]

  def add_item
    @grocery_list = current_user.grocery_list # user's grocery list
    @line_item = LineItem.new(item_id: params[:id], quantity: 1, grocery_list: @grocery_list) # key value pair, hard-coded quantity
    @line_item.save
    redirect_to search_path # stay on the same page
  end

  def adjust_item
    # @line_item = LineItem.find(params[:id])
    # @line_item.quantity.update

    # if @line_item.save
    #   flash[:success] = "Quantity is updated!"
    # else
    #   flash[:error] = "Failed to update quantity."
    # end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to search_path
  end

  private

  def line_items_params
    params.require(:booking).permit(:quantity)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
