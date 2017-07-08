class Site::MakeTripsHash < ApplicationService

  def initialize(trips, filter)
    @trips = trips
    @filter = filter
  end

  def call
    trips.each do |trip|
      direction = direction(trip)
      trips_hash[direction] ||= []
      trips_hash[direction] << {
        id: trip.id,
        trip: trip_endpoints(trip),
        activity: trip.activity,
        time: trip_time(trip),
        timestamp: Time.zone.parse(trip.start_time).to_i,
        carrier: trip.carrier_name,
        total_cost: trip_total_cost(trip)
      }
    end

    trips_hash.map do |direction, array|
      {
        key: "#{direction} - #{filter}",
        direction: direction,
        trips: array.sort_by { |h| h[:timestamp] }
      }
    end
  end

  private

  attr_reader :trips, :filter

  def trips_hash
    @_trips_hash ||= {}
  end

  def direction(trip)
    "#{trip.start_city_name} - #{trip.end_city_name}"
  end

  def trip_endpoints(trip)
    "#{trip.station_begin_name} - #{trip.station_end_name}"
  end

  def trip_time(trip)
    "#{trip.start_time} - #{trip.end_time}"
  end

  def trip_total_cost(trip)
    "#{trip.total_cost.to_f} #{trip.currency_name}"
  end
end
