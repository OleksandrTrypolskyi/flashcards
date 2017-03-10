class HomeController < ApplicationController
  def index
    @card = Card.for_review.take
  end
end
