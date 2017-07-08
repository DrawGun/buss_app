require "rails_helper"

describe Seeds::CalculateSchedule, :aggregate_failures do
  let(:start_time) { "11:00" }
  let(:end_time) { "18:00" }
  let(:trip_1) { create(:trip, :raw, start_time: start_time, end_time: end_time) }
  let(:trip_2) { create(:trip, :raw, start_time: start_time, end_time: end_time) }

  before do
    arr = [
      "15.05.2017", "22.05.2017", "29.05.2017", "05.06.2017",
      "17.05.2017", "24.05.2017", "31.05.2017", "07.06.2017",
      "19.05.2017", "26.05.2017", "02.06.2017", "09.06.2017"
    ]

    arr.each do |date_str|
      date = Date.parse(date_str)
      trip_item_1 = build(
        :trip_item,
        trip: trip_1,
        start_date: date,
        end_date: date,
        auto_created: true
      )

      trip_item_2 = build(
        :trip_item,
        trip: trip_2,
        start_date: date + 1.day,
        end_date: date + 1.day,
        auto_created: true
      )

      trip_item_1.save!
      trip_item_2.save!
    end
  end

  context "call" do
    before do
      described_class.call()
      trip_1.reload
      trip_2.reload
    end

    it "filled trip_1" do
      expect(trip_1.monday).to be true
      expect(trip_1.tuesday).to be false
      expect(trip_1.wednesday).to be true
      expect(trip_1.thursday).to be false
      expect(trip_1.friday).to be true
      expect(trip_1.saturday).to be false
      expect(trip_1.sunday).to be false
    end

    it "filled trip_2" do
      expect(trip_2.monday).to be false
      expect(trip_2.tuesday).to be true
      expect(trip_2.wednesday).to be false
      expect(trip_2.thursday).to be true
      expect(trip_2.friday).to be false
      expect(trip_2.saturday).to be true
      expect(trip_2.sunday).to be false
    end
  end
end
