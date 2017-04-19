# Check if user correctly remember translation of word
class CardVerificationController < ApplicationController
  def update
    @card = Card.find_by(id: params[:id])
    if @card.confirm_reviewing(params[:card][:original_text])
      correct_check
    else
      wrong_check
    end
  end

  private

  def correct_check
    @card.update_review_date_after_correct_check
    flash[:success] = "Translation is correct :)
                       Next test: #{@card.review_date}"
    redirect_to root_path
  end

  def wrong_check
    @card.update_review_date_after_wrong_check
    flash[:danger] = 'Translation is not correct :( Try again!'
    redirect_to root_path
  end
end
