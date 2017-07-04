class Seeds::CalculateSchedule < ApplicationService

  def initialize
    trip_items_start_dates = TripItem.sorted.map { |ti| ti.start_date.to_date }.uniq.sort
    from = trip_items_start_dates.first
    to = trip_items_start_dates.last

    from.upto(to) do |day|
      wday = day.wday
      shedule[wday] ||= 0
      shedule[wday] += 1
    end
  end

  def call
    Trip.includes(:trip_items).sorted.find_each do |trip|
      trip_obj = trip.trip_items.each_with_object({}) do |trip_item, obj|
        wday = trip_item.start_date.wday

        obj[wday] ||= 0
        obj[wday] += 1
      end

      hash = {}
      Trip::SCHEDULE.keys.each_with_index do |day, index|
        hash[day] = trip_obj[index].to_i >= shedule[index]
      end

      trip.update(hash)
    end
  end

  private

  attr_reader :min_trips

  def day
    86400
  end

  def shedule
    @_shedule ||= {}
  end
end
