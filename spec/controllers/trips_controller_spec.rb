require "rails_helper"

describe Site::TripsController, :aggregate_failures do
  include_context "Application JSON headers"

  let!(:trip_1) { create(:trip, :daily) }
  let!(:trip_2) { create(:trip, :daily) }
  let!(:trip_3) { create(:trip, :daily) }
  let!(:trip_4) { create(:trip, :daily) }
  let!(:trip_5) { create(:trip, :monday) }
  let!(:trip_6) { create(:trip, :friday) }
  let!(:trip_7) { create(:trip, :monday) }


  context "GET #index" do
    let(:request_attributes) { {} }
    let(:send_request) { get :index, params: request_attributes }

    after do
      expect(response).to have_http_status 200
    end

    it "with params == all" do
      request_attributes[:filter] = :all
      send_request

      expect(symbolized_json.size).to eq(4)
      expect(index_trip_ids).to include(trip_1.id, trip_2.id, trip_3.id, trip_4.id)
    end

    it "with params == monday" do
      request_attributes[:filter] = :monday
      send_request

      expect(symbolized_json.size).to eq(6)
      expect(index_trip_ids).to include(trip_1.id, trip_2.id, trip_3.id, trip_4.id, trip_5.id, trip_7.id)
    end

    it "witout any params" do
      send_request

      expect(symbolized_json.size).to eq(4)
      expect(index_trip_ids).to include(trip_1.id, trip_2.id, trip_3.id, trip_4.id)
    end
  end
end
