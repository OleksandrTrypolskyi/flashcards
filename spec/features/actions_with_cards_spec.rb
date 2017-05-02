require 'rails_helper'

RSpec.feature 'Actions with cards:', type: :feature do
  let!(:user) { create :user }
  let!(:deck) { create :deck, user: user }
  let!(:card) { create :card, user: user, deck: deck }

  before(:each) do
    page.driver.header('Accept-Language', 'en')
  end

  describe 'When not logged in' do
    it 'cannot create card' do
      visit 'dashboard/cards/new'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot show all users cards' do
      visit 'dashboard/cards'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot show card' do
      visit 'dashboard/cards/45'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot edit card' do
      visit 'dashboard/cards/45/edit'
      expect(page).to have_content('Please login or register')
    end
  end

  describe 'When logged in and there is activated deck' do
    before(:each) do
      login_user
      activate_deck
    end

    it 'can create card' do
      visit 'dashboard/cards/new'
      fill_in 'card_original_text', with: 'card'
      fill_in 'card_translated_text', with: 'карточка'
      select(deck.name, from: 'card_deck_id')
      click_button 'Create Card'
      # Epext to see the page of the just created card
      expect(page).to have_content('Card card was successfly created.')
    end

    it 'can show all users cards' do
      visit 'dashboard/cards/new'
      fill_in 'card_original_text', with: 'card'
      fill_in 'card_translated_text', with: 'карточка'
      select(deck.name, from: 'card_deck_id')
      click_button 'Create Card'
      visit dashboard_cards_path
      expect(page).to have_content('карточка')
    end

    it 'can show card' do
      visit "dashboard/cards/#{card.id}"
      expect(page).to have_content(card.translated_text)
    end

    it 'can edit card' do
      visit "dashboard/cards/#{card.id}/edit"
      fill_in 'card_original_text', with: 'card'
      fill_in 'card_translated_text', with: 'карточка'
      click_button 'Update Card'
      expect(page).to have_content('card')
    end
  end

  describe 'When logged in but there is not activated deck' do
    before(:each) do
      login_user
    end

    it 'cannot create card' do
      visit new_dashboard_card_path
      expect(page).to have_content 'Cards can be created only in a deck.'
    end
  end
end
