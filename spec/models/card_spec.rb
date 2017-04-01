require 'rails_helper'

RSpec.describe Card, :type => :model do
  DatabaseCleaner.strategy = :transaction

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
    expect(card.review_date).to eql(Date.today + 3.days)
  end

  it '.update_review_date_after_check' do
    card.update_review_date_after_check
    expect(card.review_date).to eql(Date.today + 3.days)
  end

  it '.confirm_reviewing_false' do
    expect(card.confirm_reviewing('battlestart')).to be false
  end

  it '.confirm_reviewing_true' do
    expect(card.confirm_reviewing(card.original_text)).to be true
  end
end
