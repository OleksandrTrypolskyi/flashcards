require 'rails_helper'

RSpec.feature 'Login checking', :type => :feature do

  let!(:user) { create :user_with_cards }

  describe 'Loggin process' do
    it 'login successful' do
      visit login_path
      expect(page).to have_content 'Login'
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'login'
      expect(page).to have_content 'Login successful'
    end
  end
end
