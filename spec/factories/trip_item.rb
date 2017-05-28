FactoryGirl.define do
  factory :trip_item do
    trip
    currency

    total_cost 100

    start_date { Time.zone.now }
    end_date { Time.zone.now + 30.minute }
  end
end
