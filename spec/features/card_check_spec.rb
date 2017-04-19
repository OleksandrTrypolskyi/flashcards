require 'rails_helper'

RSpec.feature 'Card checking', type: :feature do
  let!(:user) { create :user }
  let!(:deck) { create :deck, user: user }
  let!(:card) { create :card, user: user, deck: deck }

  describe 'Home page when all cards are checked' do
    it 'Displays correct view of home page when not logged in' do
      visit root_path
      expect(page).to have_content 'Please login or register'
    end
  end

  describe 'Card checking' do
    before(:each) do
      login_user
      card.update_attribute(:review_date, Date.today - 10.days)
      activate_deck
      visit root_path
      expect(page).to have_content("Do you remember the translation
                                    of this word: #{card.translated_text}")
    end

    it 'Card checking success' do
      fill_in 'card_original_text', with: card.original_text
      click_button 'Check'
      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Translation is correct :)'
    end

    it 'Card checking fails' do
      fill_in 'card_original_text', with: 'wrong_translation'
      click_button 'Check'
      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Translation is not correct :( Try again!'
    end

    it 'Displays correct view of home page' do
      card.update_attribute(:review_date, Date.today + 10.days)
      visit root_path
      expect(page).to have_content 'Первый в мире удобный менеджер
                                    флеш-карточек. Именно так.'
    end
  end
end
