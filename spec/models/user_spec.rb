require 'rails_helper'

 RSpec.describe User, type: :model do

  let!(:user) { create :user_with_cards }

  # Also check correct work of factories.
  it 'user_and_his_cards_must_be_valid' do
    user.valid?
    expect(user.errors).to be_empty
    user.cards.first.valid?
    expect(user.cards.first.errors).to be_empty
  end

  it 'downcase_email_after_save' do
    user.email = 'GOOGLE@GOOGLE.COM'
    user.save
    expect(user.email).to eq('google@google.com')
  end
 end
