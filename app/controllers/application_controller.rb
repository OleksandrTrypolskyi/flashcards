class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    unless current_user
      flash[:alert] = 'Please login or register'
      redirect_to login_path
    end
  end
end
