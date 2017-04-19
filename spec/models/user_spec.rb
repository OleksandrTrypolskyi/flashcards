require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:deck) { create :deck, user: user }
  let!(:card) { create :card, user: user, deck: deck }

  # Also check correct work of factories.
  it 'user_and_his_cards_must_be_valid' do
    user.valid?
    expect(user.errors).to be_empty
    card.valid?
    expect(card.errors).to be_empty
  end

  it 'downcase_email_after_save' do
    user.email = 'GOOGLE@GOOGLE.COM'
    user.save
    expect(user.email).to eq('google@google.com')
  end
end
