require 'rails_helper'

RSpec.feature 'Card checking', :type => :feature do
  DatabaseCleaner.strategy = :transaction

  describe 'All cards are checked' do
    let(:card) { create :card }

    it 'Displays correct view of home page' do
      visit root_path
      expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек. Именно так.'
    end
  end

  describe 'Card checking' do
    let(:card) {create :card}

    before (:each) do
      card.update_attribute(:review_date, Date.today - 10.days)
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
  end
end
