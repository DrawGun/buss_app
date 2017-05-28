require "rails_helper"

describe Trip do
  subject do
    create(:trip)
  end

  context "assotiations" do
    it { should belong_to(:start_city).class_name('City').with_foreign_key('start_city_id') }
    it { should belong_to(:end_city).class_name('City').with_foreign_key('end_city_id') }
    it { should belong_to(:station_begin).class_name('Station').with_foreign_key('station_begin_id') }
    it { should belong_to(:station_end).class_name('Station').with_foreign_key('station_end_id') }
    it { should belong_to(:carrier) }
    it { should belong_to(:currency) }
  end

  context "validations" do
    it { should validate_presence_of(:start_city) }
    it { should validate_presence_of(:end_city) }
    it { should validate_presence_of(:station_begin) }
    it { should validate_presence_of(:station_end) }
    it { should validate_presence_of(:carrier) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:total_cost) }
    it { should validate_numericality_of(:total_cost).is_greater_than_or_equal_to(0) }

    it "check_trip_dates" do
      t1 = Time.zone.now
      t2 = t1 + 30.minutes
      trip = build(:trip, start_date: t2, end_date: t1)
      expect(trip.valid?).to be_falsey
      expect(trip.errors.messages).to eq({start_date: ["Дата начала поездки не может быть позже даты конца поездки"]})
    end
  end
end
