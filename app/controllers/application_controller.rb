# File for ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    # unless current_user
    #  flash[:warning] = 'Please login or register'
    #  redirect_to login_path
    # else
    #  current_user
    # end
    # Correct for rubocop. Is it correct???
    if current_user
    else
      flash[:warning] = 'Please login or register'
      redirect_to login_path
    end
  end
end
