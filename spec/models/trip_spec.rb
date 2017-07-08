require "rails_helper"

describe Trip, :aggregate_failures do
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
    it { should have_many(:trip_items) }
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

    it "trip time by scope" do
      start_time = subject.start_time
      start_city = subject.start_city
      end_city = subject.end_city
      station_begin = subject.station_begin
      station_end = subject.station_end
      carrier = subject.carrier


      new_trip = build(:trip,
        start_time: start_time,
        total_cost: subject.total_cost,
        start_city: start_city,
        end_city: end_city,
        station_begin: station_begin,
        station_end: station_end,
        carrier: carrier
      )

      expect(new_trip.valid?).to eq(false)
      expect(new_trip.errors.messages).to eq({
        :start_time=>["уже существует"]
      })
    end
  end
end
