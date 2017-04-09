require 'rails_helper'

RSpec.feature 'Actions with users', :type => :feature do
  let!(:user) { create :user_with_cards }

  describe 'Creating of user' do
    before(:each) do
      visit registration_path
    end

    it 'user can be registered and logged in' do
      fill_in 'user_email', with: 'someting@yandex.ru'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Create User'
      # Editing link avilable only for registered users.
      expect(page).to have_content('Edit user')
    end

    it 'shows an error if password is too short' do
      fill_in 'user_email', with: 'someting@yandex.ru'
      fill_in 'user_password', with: 'p'
      fill_in 'user_password_confirmation', with: 'p'
      click_button 'Create User'
      expect(page).to have_content('too short')
    end

    it 'shows an error if password is not simmilar to password_confirmation' do
      fill_in 'user_email', with: 'someting@yandex.ru'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password11'
      click_button 'Create User'
      expect(page).to have_content("doesn't match")
    end

    it 'shows an error if user with such email was already registered' do
      fill_in 'user_email', with: "#{user.email}"
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Create User'
      expect(page).to have_content('Email has already been taken')
    end
  end

  describe 'When not logged in' do
      it 'cannot edit user' do
        visit "/users/#{user.id}/edit"
        expect(page).to have_content('Please login or register')
      end
      # if cannot edit user so cannot delete user and show user.
  end

  describe 'When logged in' do
    before(:each) do
      login_user
    end

    it 'can edit user' do
      visit "/users/#{user.id}/edit"
      expect(page).to have_content("Edit #{user.email}")
      fill_in 'user_email', with: 'another@emaill.ruru'
      fill_in 'user_password', with: 'strongpassword'
      fill_in 'user_password_confirmation', with: 'strongpassword'
      click_button 'Update User'
      expect(page).to have_content('another@emaill.ruru')
    end
    # if can edit user so can delete user and show user.
  end
end
