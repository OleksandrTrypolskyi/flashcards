class CardVerificationController < ApplicationController

  def update
    @card = Card.find_by(original_text: params[:original_text])
    if session[:original_text] == session[:original_text_verification]
      flash[:notice] = "Translation is correct :)"
      @card.set_review_date
      @card.save
      redirect_to cards_path
    else
      flash[:alert] = "Translation is not correct :( Try again!"
      redirect_to home_url
    end
  end

end
