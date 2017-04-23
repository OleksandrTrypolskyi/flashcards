require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { create :card }

  it '.original_cannot_be_similar_to_translated_successful' do
    card.valid?
    expect(card.errors[:base]).to be_empty
  end

  it '.original_cannot_be_similar_to_translated_fails' do
    card.update_attribute(:translated_text, 'plane')
    card.valid?
    expect(card.errors[:base]).not_to be_empty
  end

  it '.set_review_date' do
    card.set_review_date
    expect(card.review_date.to_date).to eql(Date.today)
  end

  context 'ReviewDateCalculator.review_date_after_correct_check' do
    # check_card(number, quality)
    # quality can be only 1..5
    # review_date_helper(number_of_successfull_checks)
    it 'correct_parameters_after_1_check' do
      check_card(1, 5)
      review_date_helper(1)
    end

    it 'correct_parameters_after_2_checks' do
      check_card(2, 4)
      review_date_helper(2)
    end

    it 'correct_parameters_after_3_checks' do
      check_card(3, 3)
      review_date_helper(3)
    end

    it 'correct_parameters_after_4_checks' do
      check_card(4, 2)
      review_date_helper(4)
    end

    it 'correct_parameters_after_5_checks' do
      check_card(5, 1)
      review_date_helper(5)
    end

    it 'correct_parameters_after_6_checks' do
      check_card(6, 4)
      review_date_helper(6)
    end
  end

  context 'ReviewDateCalculator.review_date_after_wrong_check' do
    before(:each) do
      check_card(5, 1)
      review_date_helper(5)
    end

    it 'same_review_date_after_1_wrong_check' do
      wrong_check_card(1)
      expect(card.number_of_wrong_checks).to eql(1)
      review_date_helper(5)
    end

    it 'same_review_date_after_2_wrong_checks' do
      wrong_check_card(2)
      expect(card.number_of_wrong_checks).to eql(2)
      review_date_helper(5)
    end

    it 'same_review_date_after_3_wrong_checks' do
      wrong_check_card(3)
      expect(card.number_of_wrong_checks).to eql(3)
      review_date_helper(5)
    end

    it 'reset_parameters_after_4_wrong_checks' do
      wrong_check_card(4)
      date = Time.now
      expect(card.review_date.to_date).to eql(date.to_date)
      expect(card.number_of_successfull_checks).to eql(0)
      expect(card.number_of_wrong_checks).to eql(0)
    end
  end

  it '.confirm_check_false' do
    expect(card.confirm_check('battlestart')).to be false
  end

  it '.confirm_chcek_true' do
    expect(card.confirm_check(card.original_text)).to be true
  end

  it '.confirm_check_misprint_true' do
    expect(card.confirm_check_misprint('plaen')).to be true
  end

  it '.confirm_check_misprint_false' do
    expect(card.confirm_check_misprint('battlestart')).to be false
  end
end
