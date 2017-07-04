require "rails_helper"

describe TripPresenter, type: :presenter do

  let!(:trip) { create(:trip, :daily) }

  it "description" do
    start_city_name = trip.start_city_name
    station_begin_name = trip.station_begin_name
    end_city_name = trip.end_city_name
    station_end_name = trip.station_end_name

    message = "#{start_city_name}, #{station_begin_name} - #{end_city_name}, #{station_end_name}"
    expect(message).to eq trip.description
  end

  it "activity" do
    expect(trip.activity).to eq "Ежедневно"
  end
end
