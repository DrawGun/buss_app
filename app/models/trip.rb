class Trip < ApplicationRecord
  include DefaultScopes
  include TripPresenter

  SCHEDULE = {
    sunday: "Вс",
    monday: "Пн",
    tuesday: "Вт",
    wednesday: "Ср",
    thursday: "Чт",
    friday: "Пт",
    saturday: "Сб"
  }

  belongs_to :start_city, class_name: "City", foreign_key: :start_city_id
  belongs_to :end_city, class_name: "City", foreign_key: :end_city_id
  belongs_to :station_begin, class_name: "Station", foreign_key: :station_begin_id
  belongs_to :station_end, class_name: "Station", foreign_key: :station_end_id
  belongs_to :carrier, inverse_of: :trips

  has_many :trip_items, inverse_of: :trip

  validates :start_city, :end_city, :station_begin, :station_end,
    :carrier, presence: true

  delegate :name, to: :start_city, prefix: true
  delegate :name, to: :end_city, prefix: true
  delegate :name, to: :station_begin, prefix: true
  delegate :name, to: :station_end, prefix: true
  delegate :name, to: :carrier, prefix: true

  scope :daily, -> { where(sunday: true, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true) }
  scope :by_wday, -> (by_wday) { where(by_wday => true) }

  class << self
    def available_collection
      self.sorted.map { |t| [t.description, t.id] }
    end
  end

  def daily?
    monday && tuesday && wednesday && thursday && friday && saturday && sunday
  end
end
