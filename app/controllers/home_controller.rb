class HomeController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    @order_item = current_order.order_items.new
    @user = User.find_by(params[:id])
  end

end
