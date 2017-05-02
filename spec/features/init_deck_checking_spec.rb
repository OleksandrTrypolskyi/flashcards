require 'rails_helper'

RSpec.feature 'Init_deck_checking', type: :feature do
  let!(:user) { create :user }

  before(:each) do
    page.driver.header('Accept-Language', 'en')
  end

  describe 'User_who_does_not_have_deck' do
    before(:each) do
      login_user
    end

    it 'propose_to_create_deck_when_try_to_create_card' do
      visit new_dashboard_card_path
      expect(page).to have_content('Cards can be created only in a deck')
    end
  end
end
