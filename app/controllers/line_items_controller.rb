class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:adjust_item]

  def add_item
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

  private

  def line_items_params
    params.require(:booking).permit(:quantity)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
