require "rails_helper"

describe City do
  subject { create(:city) }

  context "validations" do
    it { should have_many(:stations) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it "skips whitespaces" do
      city_name = "Киев"
      subject.update(name: "   #{city_name} ")
      expect(subject.name).to eq(city_name)
    end
  end
end
