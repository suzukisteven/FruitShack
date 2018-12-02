class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully created an account!"
      redirect_to '/login'
    else
      flash[:error] = "Your account could not be created. Please try again."
      redirect_to '/signup'
    end
  end

  private def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end

end
