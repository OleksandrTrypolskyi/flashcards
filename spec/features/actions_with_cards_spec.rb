require 'rails_helper'

RSpec.feature 'Actions with cards', :type => :feature do
  DatabaseCleaner.strategy = :transaction
  let!(:user) { create :user_with_cards }

  describe 'When not logged in' do
    it 'cannot create card' do
      visit 'cards/new'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot show all users cards' do
      visit 'cards'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot show card' do
      visit 'cards/45'
      expect(page).to have_content('Please login or register')
    end

    it 'cannot edit card' do
      visit 'cards/45/edit'
      expect(page).to have_content('Please login or register')
    end
  end

  describe 'When logged in' do
    before(:each) do
      visit login_path
      expect(page).to have_content 'Login'
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'login'
      expect(page).to have_content 'Login successful'
    end

    it 'can create card' do
      visit '/cards/new'
      fill_in 'card_original_text', with: 'card'
      fill_in 'card_translated_text', with: 'карточка'
      click_button 'Create Card'
      # Epext to see the page of the just created card
      expect(page).to have_content('card')
    end

    it 'can show all users cards' do
      visit '/cards'
      expect(page).to have_content(user.cards.first.original_text)
    end

    it 'can show card' do
      visit "/cards/#{user.cards.first.id}"
      expect(page).to have_content(user.cards.first.translated_text)
    end

    it 'can edit card' do
      visit "/cards/#{user.cards.first.id}/edit"
      fill_in 'card_original_text', with: 'card'
      fill_in 'card_translated_text', with: 'карточка'
      click_button 'Update Card'
      expect(page).to have_content('card')
    end

    let!(:card) { create :card, id: '2' }

    # if cannot edit so cannot delete and show as well.
    it 'can edit only own card' do
      visit "/cards/2/edit"
      expect(page).to have_content('Operations are possible only with own cards')
    end
  end
end
