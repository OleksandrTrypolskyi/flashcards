# File for OauthsController
class Home::OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_path
      flash[:notice] = "Logged in from #{provider.titleize}!"
    else
      # Initialize new user from provider informations.
      # If a provider doesn't give required informations
      # or username/email is already taken,
      # we store provider/user infos into a session
      @user = create_and_validate_from(provider)
      if @user = User.find_by_email(session[:incomplete_user][:user_hash][:email])
        @user.authentications.build(provider: provider,
        uid: session[:incomplete_user][:provider][:uid]).save(validate: false)
        auto_login(@user)
        redirect_to root_path
        flash[:notice] = "Logged in from #{provider.titleize}!
        Added new authentication to user: #{@user.email}"
      else
        redirect_to root_path
        flash[:alert] = "Failed to login from #{provider.titleize}!"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
