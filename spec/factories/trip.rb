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
  end
end
