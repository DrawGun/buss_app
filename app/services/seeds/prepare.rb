class Seeds::Prepare < ApplicationService
  def initialize(hash)
    @hash = hash
  end

  def call
    return if hash.values.include?(nil)

    TripItem.create(
      trip_id: trip.id,
      start_date: hash[:start_date],
      end_date: hash[:end_date],
      auto_created: true
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
        carrier_id: carrier.id,
        total_cost: hash_value(:total_cost),
        currency_id: currency.id,
        start_time: hash_value(:start_time),
        end_time: hash_value(:end_time)
      )
    end
  end
end
