require "rails_helper"

describe Trip::CalculateSchedule, :aggregate_failures do
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
        end_date: date,
        auto_created: true
      )

      trip_item.save!
    end
  end

  context "call" do
    before do
      described_class.call(trip)
      trip.reload
    end

    it "filled database" do
      expect(trip.monday).to be true
      expect(trip.tuesday).to be false
      expect(trip.wednesday).to be true
      expect(trip.thursday).to be false
      expect(trip.friday).to be true
      expect(trip.saturday).to be false
      expect(trip.sunday).to be false
    end
  end
end
