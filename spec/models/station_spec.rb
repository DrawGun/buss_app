require "rails_helper"

describe Station do
  subject do
    create(:station)
  end

  context "assotiations" do
    it { should belong_to(:city) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:city_id) }
    it { should validate_presence_of(:city) }

    it "skips whitespaces" do
      station_name = "Автостанция 'Новоясеневская'"
      subject.update(name: "   #{station_name} ")
      expect(subject.name).to eq(station_name)
    end
  end
end
