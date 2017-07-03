FactoryGirl.define do
  factory :trip_item do
    trip

    start_date { Time.zone.now }
    end_date { Time.zone.now + 30.minute }
  end
end
