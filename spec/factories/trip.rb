FactoryGirl.define do
  factory :trip do
    association :start_city, factory: :city
    association :end_city, factory: :city
    association :station_begin, factory: :station
    association :station_end, factory: :station

    carrier
    currency

    total_cost 100

    start_date { Time.zone.now }
    end_date { Time.zone.now + 30.minute }
  end
end
