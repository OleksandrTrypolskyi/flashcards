class HomeController < ApplicationController
  before_action :logged_in?

  def index
    if current_user.current_deck
      @card = current_user.current_deck.cards.for_review.take
    else
      @card = current_user.cards.for_review.take
    end
  end
end
