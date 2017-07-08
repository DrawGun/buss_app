class TripItem < ApplicationRecord
  include DefaultScopes
  include TripItemPresenter

  attr_accessor :auto_created

  belongs_to :trip, inverse_of: :trip_items

  validate :check_trip_dates

  delegate :description, :carrier_name, :start_point, :end_point,
    :activity, :start_time, :end_time, to: :trip, prefix: true

  scope :sorted_by_start_date, -> { order(start_date: :asc) }

  after_save :calculate_trip_schedule, unless: :auto_created

  private

  def check_trip_dates
    if start_date > end_date
      errors.add(:start_date, I18n.t("activerecord.errors.trip_item.start_date_greater_than_end_date"))
    end
  end

  def calculate_trip_schedule
    Trip::CalculateSchedule.call(trip)
  end
end
