def login_user
  visit login_path
  expect(page).to have_content 'Login'
  fill_in 'email', with: user.email
  fill_in 'password', with: 'password'
  click_button 'login'
  expect(page).to have_content 'Login successful'
end

def activate_deck
  visit decks_path
  click_on 'Activate Deck'
  expect(page).to have_content 'Deck was activated.'
end
