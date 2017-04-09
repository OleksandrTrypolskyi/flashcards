FactoryGirl.define do
  factory :deck do
    name "MyString"
    after(:create) do |deck|
      create_list(:card, 1, deck: deck)
    end
  end
end
