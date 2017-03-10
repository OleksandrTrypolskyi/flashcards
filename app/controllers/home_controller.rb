class HomeController < ApplicationController
  def index
    @card_for_review = Card.cards_must_be_repeated.take
  end
end
