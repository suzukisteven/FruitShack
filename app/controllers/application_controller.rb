class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :authorize, :current_order

  # Return the current order if it exists, otherwise create a new order if none exists.
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  private

  # Finds user by securely generated auth_token if it exists and sets it to an instance variable of current_user
  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  # Checks if current_user exists(present), if so, the user is signed in.
  def signed_in?
    current_user.present?
  end

  # Unless current_user exists, redirect to login page.
  def authorize
    redirect_to '/login' unless current_user
  end

end
