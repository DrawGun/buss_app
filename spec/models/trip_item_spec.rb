require "rails_helper"

describe TripItem do
  subject do
    create(:trip_item)
  end

  context "assotiations" do
    it { should belong_to(:currency) }
  end

  context "validations" do
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:total_cost) }
    it { should validate_numericality_of(:total_cost).is_greater_than_or_equal_to(0) }

    it "check_trip_dates" do
      t1 = Time.zone.now
      t2 = t1 + 30.minutes
      trip_item = build(:trip_item, start_date: t2, end_date: t1)
      expect(trip_item.valid?).to be_falsey
      expect(trip_item.errors.messages).to eq({start_date: ["Дата начала поездки не может быть позже даты конца поездки"]})
    end
  end

  context "callbacks" do
    it "set_trip_activity" do
      trip = subject.trip
      wday = Russian::strftime(subject.start_date, "%a")
      expect(trip.activity).to eq(wday)
    end
  end
end
