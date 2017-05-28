require "rails_helper"

describe Currency do
  subject { create(:currency) }

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it "skips whitespaces" do
      currency_name = "RU"
      subject.update!(name: "   #{currency_name} ")
      expect(subject.name).to eq(currency_name)
    end
  end
end

