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
      t1 = Time.zone.now
      t2 = t1 + 30.minutes
      trip_item = build(:trip_item, start_date: t2, end_date: t1)
      expect(trip_item.valid?).to be_falsey
      expect(trip_item.errors.messages).to eq({start_date: ["Дата начала поездки не может быть позже даты конца поездки"]})
    end
  end

  context "getters" do
    let(:start_time) { "11:30" }
    let(:end_time) { "13:30" }

    it "start_time=" do
      subject.start_time = start_time
      subject.end_time = end_time
      subject.save!

      expect(subject.start_date.strftime("%H:%M")).to eq(start_time)
      expect(subject.end_date.strftime("%H:%M")).to eq(end_time)
    end
  end
end
