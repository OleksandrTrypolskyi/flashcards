require 'rails_helper'

RSpec.describe Card, :type => :model do
  it '.original_cannot_be_similar_to_translated' do
    card = Card.new(original_text: 'bus', translated_text: 'bus')
    card.valid?
    expect(card.errors[:base]).not_to be_empty
  end

  it '.update_review_date' do
    card = Card.new(translated_text: 'bus',
    original_text: 'автобус', review_date: Date.today)
    card.update_review_date
    expect(card.review_date).to eql(Date.today + 3.days)
  end

  it '.confirm_reviewing false' do
    card = Card.new(original_text: 'hause')
    expect(card.confirm_reviewing('battlestart')).to be false
  end

  it '.confirm_reviewing true' do
    card = Card.new(original_text: "house")
    expect(card.confirm_reviewing('house')).to be true
  end
end
