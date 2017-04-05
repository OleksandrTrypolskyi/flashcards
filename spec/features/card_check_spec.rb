require 'rails_helper'

RSpec.feature 'Card checking', :type => :feature do
  let!(:user) { create :user_with_cards }

  describe 'Home page when all cards are checked' do
    it 'Displays correct view of home page when not logged in' do
      visit root_path
      expect(page).to have_content 'Please login or register'
    end
  end

  describe 'Card checking' do
    before(:each) do
      visit login_path
      expect(page).to have_content 'Login'
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'login'
      expect(page).to have_content 'Login successful'
      user.cards.first.update_attribute(:review_date, Date.today - 10.days)
      visit root_path
      expect(page).to have_content 'Do you remember the translation of this word:'
    end

    it 'Card checking success' do
      fill_in 'card_original_text', with: 'plane'
      click_button 'Check'
      expect(current_path).to eq(cards_path)
      expect(page).to have_content 'Translation is correct :)'
    end

    it 'Card checking fails' do
      fill_in 'card_original_text', with: 'wrong_translation'
      click_button 'Check'
      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Translation is not correct :( Try again!'
    end

    it 'Displays correct view of home page' do
      user.cards.first.update_attribute(:review_date, Date.today + 10.days)
      visit root_path
      expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек. Именно так.'
    end
  end
end
