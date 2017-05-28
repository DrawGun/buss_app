FactoryGirl.define do
  factory :currency do
    sequence(:name) { |n| "Валюта - #{n}" }
  end
end
