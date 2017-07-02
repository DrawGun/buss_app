class Site::TripsController < Site::BaseController
  respond_to :json
  before_action :set_trip_items

  def index
    respond_with @trips, each_serializer: Site::TripSerializer
  end

  private

  def set_trip_items
    trips = if params[:filter].include?("all")
      Trip.daily
    else
      query = params[:filter].split(",").map { |v| "#{v} = 't'"}.join(" OR ")
      Trip.where(query)
    end

    @trips = trips.includes(:currency, :start_city, :station_begin, :end_city, :station_end, :carrier)
      .page(params[:page].to_i).per(10)
  end
end
