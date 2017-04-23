# Class for calculatnig of the next review date after card checking
class ReviewDateCalculator
  def initialize(card)
    @card = card
  end

  def review_date_after_successful_check(quality)
    @card.number_of_successfull_checks += 1
    if @card.number_of_successfull_checks == 1
      @card.interval = 1
    elsif @card.number_of_successfull_checks == 2
      @card.interval = 6
    else
      @card.e_factor = @card.e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      @card.e_factor = 1.3 if @card.e_factor < 1.3
      @card.interval  *= @card.e_factor
    end
    @card.review_date = Time.now + @card.interval.days
    @card.save
  end

  def review_date_after_wrong_check
    if @card.number_of_wrong_checks == 3
      @card.set_review_date
      @card.number_of_wrong_checks = 0
      @card.number_of_successfull_checks = 0
    else
      @card.number_of_wrong_checks += 1
    end
    @card.save
  end
end
