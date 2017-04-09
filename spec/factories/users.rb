FactoryGirl.define do
  factory :user do
    email 'email@email.com'
    password 'password'
    password_confirmation 'password'

    factory :user_with_cards do
      after(:create) do |user|
        create_list(:deck, 1, user: user)
      end
    end
  end
end
