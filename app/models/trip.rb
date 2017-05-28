class Trip < ApplicationRecord
  include DefaultScopes

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

  def description
    "#{start_city_name}, #{station_begin_name} - #{end_city_name}, #{station_end_name}"
  end

  class << self
    def available_collection
      self.sorted.map { |t| [t.description, t.id] }
    end
  end
end
