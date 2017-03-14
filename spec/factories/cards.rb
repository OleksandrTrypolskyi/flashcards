FactoryGirl.define do
  factory :card do
    original_text 'plane'
    translated_text { "перевод_слова_#{original_text}" }
    review_date { Date.today }
  end
  after(:create) do |card|
    card.review_date = Date.today - 10.days
    card.save
  end
end
