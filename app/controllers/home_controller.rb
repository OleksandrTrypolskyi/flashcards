class HomeController < ApplicationController
  def index
    @card = current_user.cards.for_review.take if logged_in?
  end
end
