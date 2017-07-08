require "rails_helper"

describe TripItem, :aggregate_failures do
  subject do
    create(:trip_item)
  end

  context "assotiations" do
    it { should belong_to(:trip) }
  end

  context "validations" do
    it "check_trip_dates" do
      t1 = Date.today
      t2 = 1.day.ago
      trip_item = build(:trip_item, start_date: t1, end_date: t2)
      expect(trip_item.valid?).to be_falsey
      expect(trip_item.errors.messages).to eq({start_date: ["Дата начала поездки не может быть позже даты конца поездки"]})
    end
  end

  context "callbacks" do
    it "calculate_trip_schedule after update unless: :auto_created" do
      tomorrow = 1.day.from_now.beginning_of_day
      wday = tomorrow.wday
      wday_str = Trip::SCHEDULE.keys[wday]

      subject.reload.update!(start_date: tomorrow, end_date: tomorrow)
      expect(subject.trip.send(wday_str)).to eq(true)
    end
  end
end
