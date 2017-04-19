require 'rails_helper'

RSpec.describe Card, :type => :model do

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

  it '.update_review_date' do
    card.update_review_date
    expect(card.review_date.to_date).to eql(Date.today)
  end

  context '.update_review_date_after_correct_check' do
    it 'correct_parameters_after_1_check' do
      card.update_review_date_after_correct_check
      date = Time.now + 0.5.days
      review_date_helper(date, 1)
    end

    it 'correct_parameters_after_2_checks' do
      check_card(2)
      date = Time.now + 3.days
      review_date_helper(date, 2)
    end

    it 'correct_parameters_after_3_checks' do
      check_card(3)
      date = Time.now + 7.days
      review_date_helper(date, 3)
    end

    it 'correct_parameters_after_4_checks' do
      check_card(4)
      date = Time.now + 14.days
      review_date_helper(date, 4)
    end

    it 'correct_parameters_after_5_checks' do
      check_card(5)
      date = Time.now + 30.days
      review_date_helper(date, 5)
    end

    it 'correct_parameters_after_6_checks' do
      check_card(6)
      date = Time.now + 30.days
      review_date_helper(date, 6)
    end
  end


  context '.update_review_date_after_wrong_check' do

    before(:each) do
      5.times do
        card.update_review_date_after_correct_check
      end
      @date = Time.now + 30.days
      review_date_helper(@date, 5)
    end

    it 'same_review_date_after_1_wrong_check' do
      card.update_review_date_after_wrong_check
      expect(card.number_of_wrong_checks).to eql(1)
      review_date_helper(@date, 5)
    end

    it 'same_review_date_after_2_wrong_checks' do
      wrong_check_card(2)
      expect(card.number_of_wrong_checks).to eql(2)
      review_date_helper(@date, 5)
    end

    it 'same_review_date_after_3_wrong_checks' do
      wrong_check_card(3)
      expect(card.number_of_wrong_checks).to eql(3)
      review_date_helper(@date, 5)
    end

    it 'reset_parameters_after_4_wrong_checks' do
      wrong_check_card(4)
      date = Time.now
      review_date_helper(date, 0)
      expect(card.number_of_wrong_checks).to eql(0)
    end
  end

  it '.confirm_reviewing_false' do
    expect(card.confirm_reviewing('battlestart')).to be false
  end

  it '.confirm_reviewing_true' do
    expect(card.confirm_reviewing(card.original_text)).to be true
  end
end
