# Check if user correctly remember translation of word
class CardVerificationController < ApplicationController
  def update
    @card = Card.find_by(id: params[:id])
    if @card.confirm_reviewing(params[:card][:original_text])
      @card.update_review_date
      @card.save
      flash[:notice] = 'Translation is correct :)'
      redirect_to cards_path
    else
      flash[:alert] = 'Translation is not correct :( Try again!'
      redirect_to home_url
    end
  end
end
