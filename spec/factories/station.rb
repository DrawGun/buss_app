FactoryGirl.define do
  factory :station do
    city
    sequence(:name) { |n| "Станция - #{n}" }
  end
end
