FactoryGirl.define do
  factory :trip do
    association :start_city, factory: :city
    association :end_city, factory: :city
    association :station_begin, factory: :station
    association :station_end, factory: :station

    carrier
    currency

    start_time { "11:00" }
    end_time { "21:00" }

    total_cost { 600.53 }

    trait :daily do
      sunday true
      monday true
      tuesday true
      wednesday true
      thursday true
      friday true
      saturday true
    end

    trait :monday do
      sunday false
      monday true
      tuesday false
      wednesday false
      thursday false
      friday false
      saturday false
    end

    trait :friday do
      sunday false
      monday false
      tuesday false
      wednesday false
      thursday false
      friday true
      saturday false
    end

    trait :raw do
      sunday false
      monday false
      tuesday false
      wednesday false
      thursday false
      friday false
      saturday false
    end
  end
end
