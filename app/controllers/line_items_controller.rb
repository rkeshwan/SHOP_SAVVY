class LineItemsController < ApplicationController
  # before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token

  def add_item
    @grocery_list = User.find_by(email: "anna@gmail.com").grocery_list # user's grocery list
    @line_item = LineItem.new(item_id: params[:id], quantity: 1, grocery_list: @grocery_list) # key value pair, hard-coded quantity
    @line_item.save
    redirect_to search_path # stay on the same page
  end

  def adjust_item
    @line_item = LineItem.find(params[:id])
    if @line_item.update(line_item_params)
      # Broadcast Turbo Stream to update DOM
      html = render_to_string(template: 'pages/search', locals: { line_item: @line_item })
      turbo_stream.append(:quantity_updates, html: html)
      head :ok
    else
      render status: :unprocessable_entity
    end
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
