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

def review_date_helper(date, number)
  expect(card.review_date.to_date).to eql(date.to_date)
  expect(card.number_of_successfull_checks).to eql(number)
end
