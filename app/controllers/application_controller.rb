class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    unless current_user
      flash[:warning] = 'Please login or register'
      redirect_to login_path
    else
      current_user
    end
  end
end
