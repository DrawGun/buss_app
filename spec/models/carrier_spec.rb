require "rails_helper"

describe Carrier do
  subject { create(:carrier) }

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it "skips whitespaces" do
      carrier_name = "Киев"
      subject.update(name: "   #{carrier_name} ")
      expect(subject.name).to eq(carrier_name)
    end
  end
end
