class ProductsController < ApplicationController
  # before_action :require_login, only: [:new, :create, :destroy]
  before_action :set_product, only: [:show, :update, :delete]
  before_action :check_role, only:[:new]

  def index
    @products = Product.all.order(created_at: :desc)
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
    if current_user = nil && current_user != admin!
      flash[:error] = "Please login to continue."
      redirect_to login_path
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "A new product was successfully created."
      redirect_to root_path
    else
      @product.errors.full_messages.each_with_index do |e,i|
      # key = "error" + i.to_s
      flash[:error] = e + ". Please make changes and try again."
      redirect_to new_product_path
      end
    end
  end

  def show
    @order_item = current_order.order_items.new
  end

  private
  # Set the product by id for show, update, delete - prevent repetition
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  # returns true if user is logged in, otherwise returns false.
  def logged_in?
    !@current_user.nil?
  end

  # checks if a users role is :customer, if yes shows error msg and redirects them to root
  def check_role
  if current_user.customer?
    flash[:error] = "You are not authorized to perform that action."
    redirect_to root_path
  end
end

  # requires login using the logged_in? method above, or flashes an error message.
  def require_login
    unless logged_in?
      flash[:error] = "Please login to continue."
      redirect_to login_path
    end
  end

end
