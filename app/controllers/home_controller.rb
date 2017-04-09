class HomeController < ApplicationController
  before_action :logged_in?

  def index
    if session[:current_deck_id]
      @card = current_user.decks.find(session[:current_deck_id]).cards.for_review.take
    else
      @card = current_user.cards.for_review.take
    end
  end
end
