class TripItem < ApplicationRecord
  attr_reader :start_time, :end_time

  belongs_to :currency, inverse_of: :trip_items
  belongs_to :trip, inverse_of: :trip_items

  validates :currency, presence: true
  validates :total_cost, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :check_trip_dates

  after_save :set_trip_activity

  delegate :description, :carrier_name, :start_point, :end_point,
    :activity, to: :trip, prefix: true

  delegate :name, to: :currency, prefix: true

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

  def set_trip_activity
    trip_days = trip.trip_items.pluck(:start_date).map(&:wday).uniq

    shedule = {}

    Trip::SCHEDULE.keys.each_with_index do |day, index|
      is_active = index.in?(trip_days)
      shedule[day] = is_active
    end

    trip.update(shedule)
  end
end
