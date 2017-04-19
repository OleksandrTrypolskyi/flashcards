# Check if user correctly remember translation of word
class CardVerificationController < ApplicationController
  def update
    @card = Card.find_by(id: params[:id])
    @original_verification = params[:card][:original_text]
    if @card.confirm_check(@original_verification)
      correct_check
    elsif @card.confirm_check_misprint(@original_verification)
      almost_correct_check
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

  def almost_correct_check
    @card.update_review_date_after_correct_check
    flash[:success] = "Translation was almost correct.\n
                       Correct translation of #{@card.original_text} is
                       #{@card.translated_text}. You typed: #{@original_verification}\n
                       Next test: #{@card.review_date}"
    redirect_to root_path
  end

  def wrong_check
    @card.update_review_date_after_wrong_check
    flash[:danger] = 'Translation is not correct :( Try again!'
    redirect_to root_path
  end
end
