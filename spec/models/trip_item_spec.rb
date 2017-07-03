require "rails_helper"

describe TripItem do
  subject do
    create(:trip_item)
  end

  context "validations" do
    it "check_trip_dates" do
      t1 = Time.zone.now
      t2 = t1 + 30.minutes
      trip_item = build(:trip_item, start_date: t2, end_date: t1)
      expect(trip_item.valid?).to be_falsey
      expect(trip_item.errors.messages).to eq({start_date: ["Дата начала поездки не может быть позже даты конца поездки"]})
    end
  end
end
