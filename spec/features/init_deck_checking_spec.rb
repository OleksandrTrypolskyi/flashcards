require 'rails_helper'

RSpec.feature 'Init_deck_checking', :type => :feature do
  let!(:user) { create :user }

  describe 'User_who_does_not_have_deck' do
    before(:each) do
      visit login_path
      expect(page).to have_content 'Login'
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'login'
      expect(page).to have_content 'Login successful'
    end
    it 'shows_link_for_creation_deck' do
      visit root_path
      expect(page).to have_content('Add Deck')
    end

    it 'propose_to_create_deck_when_try_to_create_card' do
      visit new_card_path
      expect(page).to have_content('Cards can be created only in a deck')
    end
  end
end
