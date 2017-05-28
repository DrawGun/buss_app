class Trip < ApplicationRecord
  include DefaultScopes

  attr_reader :start_time, :end_time

  belongs_to :start_city, class_name: "City", foreign_key: :start_city_id
  belongs_to :end_city, class_name: "City", foreign_key: :end_city_id
  belongs_to :station_begin, class_name: "Station", foreign_key: :station_begin_id
  belongs_to :station_end, class_name: "Station", foreign_key: :station_end_id
  belongs_to :carrier, inverse_of: :trips
  belongs_to :currency, inverse_of: :trips

  validates :start_city, :end_city, :station_begin, :station_end,
    :carrier, :currency, presence: true

  validates :total_cost, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :check_trip_dates, on: :create

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
      errors.add(:start_date, I18n.t("activerecord.errors.trip.start_date_greater_than_end_date"))
    elsif start_date == end_date
      errors.add(:start_date, I18n.t("activerecord.errors.trip.start_date_equal_end_date"))
    end
  end

end
