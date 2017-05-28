FactoryGirl.define do
  factory :city do
    sequence(:name) { |n| "Город - #{n}" }
  end
end
