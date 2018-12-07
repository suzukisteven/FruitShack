class SessionsController < ApplicationController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)

    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      cookies.permanent[:auth_token] = user.auth_token
      @next = root_url
      @notice = "You have successfully signed in"

    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = root_url
      @notice = "User was successfully created. Please confirm or edit details"
    end

    session[:user_id] = user.id
    flash[:success] = @notice
    redirect_to @next
  end

  def create
    user = User.find_by_email(params[:email])

    # Facebook Oauth
    # if request.env[‘omniauth.auth’]
    #   user = User.create_with_omniauth(request.env[‘omniauth.auth’])
    #   session[:user_id] = user.id
    #   redirect_to '/'
    # end

    if user && user.authenticate(params[:password])

      if params[:remember_me]
        cookies.permanent[:auth_token] = { value: user.auth_token, expires: 2.weeks.from_now }
      else
        cookies[:auth_token] = user.auth_token
      end

      # session[:user_id] = user.id
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to '/'
      flash[:success] = "Welcome back #{user.firstname} #{user.lastname}: You have successfully signed in"
    else
      flash[:error] = "Incorrect email or password. Please try again."
      redirect_to '/login'
    end
  end

  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to '/login'
    flash[:error] = "You have signed out"
  end

end
