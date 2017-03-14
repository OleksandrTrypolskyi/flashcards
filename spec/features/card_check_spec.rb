require 'rails_helper'

RSpec.feature 'Card checking', :type => :feature do
  before(:each) do
    @card = create(:card)
  end

  after(:each) do
    @card.destroy
  end

  it 'All cards are checked' do
    @card.update_attribute(:review_date, Date.today + 3.days)
    visit root_path
    expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек. Именно так.'
  end

  it 'Card checking success' do
    visit root_path
    expect(page).to have_content 'Do you remember the translation of this word:'
    fill_in 'card_original_text', with: 'plane'
    click_button 'Check'
    expect(current_path).to eq(cards_path)
    expect(page).to have_content 'Translation is correct :)'
  end

  it 'Card checking fails' do
    visit root_path
    expect(page).to have_content 'Do you remember the translation of this word:'
    fill_in 'card_original_text', with: 'wrong_translation'
    click_button 'Check'
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Translation is not correct :( Try again!'
  end
end
