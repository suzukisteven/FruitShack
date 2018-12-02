class SessionsController < ApplicationController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)

    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "You have successfully Signed In"

    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = root_url
      @notice = "User created. Please confirm or edit details"
    end
    # sign_in(user)
    session[:user_id] = user.id
    redirect_to @next, :success => @notice
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
      flash[:success] = "You have successfully Signed In"
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
    flash[:error] = "You have Signed Out"
  end

end
