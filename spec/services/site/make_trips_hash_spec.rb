require "rails_helper"

describe Site::MakeTripsHash, :aggregate_failures do
  let(:start_time) { "11:00" }
  let(:end_time) { "18:00" }
  let(:trip) { create(:trip, :raw, start_time: start_time, end_time: end_time) }

  before do
    arr = [
      "15.05.2017", "22.05.2017", "29.05.2017", "05.06.2017",
      "17.05.2017", "24.05.2017", "31.05.2017", "07.06.2017",
      "19.05.2017", "26.05.2017", "02.06.2017", "09.06.2017"
    ]

    arr.each do |date_str|
      date = Date.parse(date_str)
      trip_item = build(
        :trip_item,
        trip: trip,
        start_date: date,
        end_date: date
      )

      trip_item.save!
      trip.reload
    end
  end

  context "call" do
    let!(:hash) { described_class.call(Trip.all, "all") }

    it "filled hash" do
      direction = "#{trip.start_city_name} - #{trip.end_city_name}"
      endpoints = "#{trip.station_begin_name} - #{trip.station_end_name}"
      time = "#{trip.start_time} - #{trip.end_time}"
      total_cost = "#{trip.total_cost.to_f} #{trip.currency_name}"
      expect(hash).to eq(
        [
          {
            :key=>"#{direction} - all",
            :direction=>"#{direction}",
            :trips=>
              [
                {
                  :id=>1,
                  :trip=>endpoints,
                  :activity=>"Пн, Ср, Пт",
                  :time=>time,
                  :timestamp=>Time.zone.parse(trip.start_time).to_i,
                  :carrier=>trip.carrier_name,
                  :total_cost=>total_cost
                }
              ]
            }
        ]
      )
    end
  end
end
