class Site::TripsController < Site::BaseController
  respond_to :json
  before_action :set_trip_items

  def index
    respond_with Site::MakeTripsHash.call(@trips, params[:filter])
  end

  private

  def set_trip_items
    trips = if params[:filter].present? && !params[:filter].include?("all")
      query = params[:filter].split(",").map { |v| "#{v} = 't'"}.join(" OR ")
      Trip.where(query)
    else
      Trip.daily
    end

    @trips = trips.includes(:currency, :start_city, :station_begin, :end_city, :station_end, :carrier)
  end
end
