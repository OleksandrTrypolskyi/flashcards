class HomeController < ApplicationController
  before_action :logged_in?

  def index
    @card = if current_user.current_deck
       current_user.current_deck.cards.for_review.take
    else
       current_user.cards.for_review.take
    end
  end
end
