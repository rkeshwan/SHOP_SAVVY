class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def add_item
  end

  def adjust_item
    @line_item = LineItem.find(params[:id])
    @line_item.update(line_item_params)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
