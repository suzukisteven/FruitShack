class ProductsController < ApplicationController
  # before_action :require_login, only: [:new, :create, :destroy]
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    # if @current_user = nil
    #   flash[:error] = "Please login to continue."
    #   redirect_to login_path
    # end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "A new product was successfully created."
      redirect_to root_path
    else
      @product.errors.full_messages.each_with_index do |e,i|
      key = "error" + i.to_s
      flash[key] = e
      redirect_to root_path
      end
    end
  end

  def show
  end

  private
  # prevent repetition
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

  # requires login using the logged_in? method above, or flashes an error message.
  def require_login
    unless logged_in?
      flash[:error] = "Please login to continue."
      redirect_to login_path
    end
  end

end
