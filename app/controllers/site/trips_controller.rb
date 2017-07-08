class Site::TripsController < Site::BaseController
  respond_to :json
  before_action :set_trip_items

  def index
    respond_with trip_hash(@trips)
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

  def trip_hash(trips)
    hash = {}
    trips.each do |trip|
      direction = "#{trip.start_city_name} - #{trip.end_city_name}"
      hash[direction] ||= []
      hash[direction] << {
        id: trip.id,
        trip: "#{trip.station_begin_name} - #{trip.station_end_name}",
        activity: trip.activity,
        time: "#{trip.start_time} - #{trip.end_time}",
        timestamp: Time.zone.parse(trip.start_time).to_i,
        carrier: trip.carrier_name,
        total_cost: "#{trip.total_cost.to_f} #{trip.currency_name}"
      }
    end

    hash.map do |direction, array|
      {
        key: "#{direction} - #{params[:filter]}",
        direction: direction,
        trips: array.sort_by { |h| h[:timestamp] }
      }
    end
  end
end
