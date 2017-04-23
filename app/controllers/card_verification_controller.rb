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
    ReviewDateCalculator.new(@card).review_date_after_successful_check(params[:time])
    flash[:success] = "#{t('Translation is correct :) Next test')}#{@card.review_date}"
    redirect_to root_path
  end

  def almost_correct_check
    ReviewDateCalculator.new(@card).review_date_after_successful_check(params[:time])
    flash[:success] = "#{t('Translation was almost correct')}\n
                       #{t('Correct translation of')}#{@card.original_text}#{t('is')}
                       #{@card.translated_text}#{t('You typed')}#{@original_verification}\n
                       #{t('Next test')}#{@card.review_date}"
    redirect_to root_path
  end

  def wrong_check
    ReviewDateCalculator.new(@card).review_date_after_wrong_check
    flash[:danger] = "#{t('Translation is not correct :( Try again')}"
    redirect_to root_path
  end
end
