class Seeds::CalculateSchedule < ApplicationService

  def initialize
    @min_trips = 4
  end

  def call
    Trip.includes(:trip_items).sorted.find_each do |trip|
      trip_obj = trip.trip_items.each_with_object({}) do |trip_item, obj|
        wday = trip_item.start_date.wday

        obj[wday] ||= 0
        obj[wday] += 1
      end

      shedule = {}
      Trip::SCHEDULE.keys.each_with_index do |day, index|
        shedule[day] = trip_obj[index].to_i >= min_trips
      end

      trip.update(shedule)
    end
  end

  private

  attr_reader :min_trips

  def day
    86400
  end
end
