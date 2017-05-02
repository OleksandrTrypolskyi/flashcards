def login_user
  visit home_login_path
  expect(page).to have_content 'Login'
  fill_in 'email', with: user.email
  fill_in 'password', with: 'password'
  click_button 'login'
  expect(page).to have_content 'Login successful'
end

def activate_deck
  visit dashboard_decks_path
  click_on 'Activate Deck'
  expect(page).to have_content 'Deck was activated.'
end

def review_date_helper(number)
  date = Time.now + card.interval.days
  expect(card.review_date.to_date).to eql(date.to_date)
  expect(card.number_of_successfull_checks).to eql(number)
end

def check_card(number, quality)
  number.times do
    ReviewDateCalculator.new(card).review_date_after_successful_check(quality)
  end
end

def wrong_check_card(number)
  number.times do
    ReviewDateCalculator.new(card).review_date_after_wrong_check
  end
end
