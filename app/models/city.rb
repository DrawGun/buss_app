class City < ApplicationRecord
  include CleanName
  include AvailableCollection
  include DefaultScopes

  validates :name, presence: true, uniqueness: true

  has_many :stations, inverse_of: :city
  has_many :start_trips, class_name: 'Trip', foreign_key: :start_city_id
  has_many :end_trips, class_name: 'Trip', foreign_key: :end_city_id
end
