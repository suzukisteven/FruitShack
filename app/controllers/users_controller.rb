class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Your account was successfully created. Please login with your details."
      redirect_to '/login'
    else
      flash[:error] = 'Your account could not be created. Please try signing up again.'
      redirect_to '/signup'
    end
  end

  def cart
    @user = current_user
  end

  def profile
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
