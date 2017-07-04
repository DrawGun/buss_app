class Site::TripsController < Site::BaseController
  respond_to :json
  before_action :set_trip_items

  def index
    respond_with @trips, each_serializer: Site::TripSerializer
  end

  private

  def set_trip_items
    trips = if params[:filter].present? && !params[:filter].include?("all")
      query = params[:filter].split(",").map { |v| "#{v} = 't'"}.join(" OR ")
      Trip.where(query)
    else
      Trip.daily
    end

    page = params[:page] ? params[:page].to_i : 1
    response.headers["TOTAL_TRIPS"] = trips.total_count.to_s

    @trips = trips.includes(:currency, :start_city, :station_begin, :end_city, :station_end, :carrier)
      .page(page).per(10)
  end
end
