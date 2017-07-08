class Seeds::CalculateSchedule < ApplicationService
  def call
    Trip.includes(:trip_items).sorted.find_each do |trip|
      Trip::CalculateSchedule.call(trip)
    end
  end
end
