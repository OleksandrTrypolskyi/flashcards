FactoryGirl.define do
  factory :card do
    original_text 'plane'
    translated_text { "перевод_слова_#{original_text}" }
    review_date { Date.today }
    user
  end
end
