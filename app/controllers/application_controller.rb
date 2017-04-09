class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    unless current_user
      flash[:alert] = 'Please login or register'
      redirect_to login_path
    else
      current_user
    end
  end

  def currnt_deck
    current_deck = current_user.decks.find(params[:dek_id])
  end
end
