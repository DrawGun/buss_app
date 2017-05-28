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
  end

  context "validations" do
    it { should validate_presence_of(:start_city) }
    it { should validate_presence_of(:end_city) }
    it { should validate_presence_of(:station_begin) }
    it { should validate_presence_of(:station_end) }
    it { should validate_presence_of(:carrier) }
    it { should have_many(:trip_items) }
  end
end
