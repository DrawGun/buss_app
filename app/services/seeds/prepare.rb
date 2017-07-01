class Seeds::Prepare < ApplicationService
  def initialize(hash)
    @hash = hash
  end

  def call
    return if hash.values.include?(nil)

    start_city = City.find_or_create_by(name: hash[:start_city_name].strip)
    station_begin = Station.find_or_create_by(city_id: start_city.id, name: hash[:station_begin_name].strip)
    end_city = City.find_or_create_by(name: hash[:end_city_name].strip)
    station_end = Station.find_or_create_by(city_id: end_city.id, name: hash[:station_end_name].strip)
    carrier = Carrier.find_or_create_by(name: hash[:carrier_name].strip)
    currency = Currency.find_or_create_by(name: hash[:currency].strip)

    trip = Trip.find_or_create_by(
      start_city: start_city,
      station_begin: station_begin,
      end_city: end_city,
      station_end: station_end,
      carrier: carrier
    )

    trip_item = TripItem.create(
      trip: trip,
      start_date: hash[:start_date],
      start_time: hash[:start_time],
      end_date: hash[:end_date],
      end_time: hash[:end_time],
      total_cost: hash[:total_cost],
      currency: currency
    )
  end

  private

  attr_reader :hash

  def hash_value(val)
    hash[val].strip
  end

  def start_city
    @_start_city ||= City.find_or_create_by(name: hash_value(:start_city_name))
  end

  def end_city
    @_end_city ||= City.find_or_create_by(name: hash_value(:end_city_name))
  end

  def station_begin
    @_station_begin ||= begin
      Station.find_or_create_by(
        city_id: start_city.id,
        name: hash_value(:station_begin_name)
      )
    end
  end

  def station_end
    @_station_end ||= begin
      Station.find_or_create_by(
        city_id: end_city.id,
        name: hash_value(:station_end_name)
      )
    end
  end

  def carrier
    @_carrier ||= Carrier.find_or_create_by(name: hash_value(:carrier_name))
  end

  def currency
    @_currency ||= Currency.find_or_create_by(name: hash_value(:currency))
  end

  def trip
    @_trip ||= begin
      Trip.find_or_create_by(
        start_city_id: start_city.id,
        station_begin_id: station_begin.id,
        end_city_id: end_city.id,
        station_end_id: station_end.id,
        carrier_id: carrier.id
      )
    end
  end
end
