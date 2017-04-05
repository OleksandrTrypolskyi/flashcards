class HomeController < ApplicationController
  before_action :logged_in?

  def index
    @card = current_user.cards.for_review.take
  end
end
