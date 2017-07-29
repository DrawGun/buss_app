class Trip::CalculateSchedule < ApplicationService

  def initialize(trip)
    @trip = trip
  end

  def call
    trip_obj = trip.trip_items.each_with_object({}) do |trip_item, obj|
      wday = trip_item.start_date.wday

      obj[wday] ||= 0
      obj[wday] += 1
    end

    hash = {}
    Trip::SCHEDULE.keys.each_with_index do |day, index|
      working_day = if trip_obj[index] && trip_obj[index].to_i >= shedule[index].to_i
        true
      else
        false
      end

      hash[day] =  working_day
    end

    trip.update(hash)
  end

  private

  attr_reader :trip

  def shedule
    @_shedule ||= begin
      shedule_obj = {}

      sorted_trip_items = TripItem.sorted_by_start_date.pluck(:start_date)
      trip_items_from = sorted_trip_items.first.to_date
      trip_items_to = sorted_trip_items.last.to_date

      trip_items_from.upto(trip_items_to) do |day|
        wday = day.wday
        shedule_obj[wday] ||= 0
        shedule_obj[wday] += 1
      end

      shedule_obj
    end
  end
end
