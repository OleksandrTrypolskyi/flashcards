class HomeController < ApplicationController
  def index
    @card = Card.cards_must_be_repeated.take
  end
end
