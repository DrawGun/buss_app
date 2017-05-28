FactoryGirl.define do
  factory :carrier do
    sequence(:name) { |n| "Физическое лицо - #{n}" }
  end
end
