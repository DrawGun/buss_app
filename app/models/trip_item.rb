class TripItem < ApplicationRecord
  attr_reader :start_time, :end_time

  belongs_to :trip, inverse_of: :trip_items

  validate :check_trip_dates

  delegate :description, :carrier_name, :start_point, :end_point,
    :activity, to: :trip, prefix: true

  scope :sorted_by_start_date, -> { order(start_date: :asc) }

  def start_time
    start_date.strftime("%H:%M")
  end

  def end_time
    end_date.strftime("%H:%M")
  end

  def start_time=(value)
    self[:start_date] = Time.zone.parse("#{self[:start_date].strftime("%d.%m.%Y")} #{value}")
  end

  def end_time=(value)
    self[:end_date] = Time.zone.parse("#{self[:end_date].strftime("%d.%m.%Y")} #{value}")
  end

  private

  def check_trip_dates
    if start_date > end_date
      errors.add(:start_date, I18n.t("activerecord.errors.trip_item.start_date_greater_than_end_date"))
    elsif start_date == end_date
      errors.add(:start_date, I18n.t("activerecord.errors.trip_item.start_date_equal_end_date"))
    end
  end
end
