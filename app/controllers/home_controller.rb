class HomeController < ApplicationController

  def index
    @user = User.find_by(params[:id])
    @products = Product.all
  end
  
end
