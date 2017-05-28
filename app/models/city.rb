class City < ApplicationRecord
  include CleanNameWithValidation
  include AvailableCollection
  include DefaultScopes

  has_many :stations, inverse_of: :city
  has_many :start_trips, class_name: 'Trip', foreign_key: :start_city_id
  has_many :end_trips, class_name: 'Trip', foreign_key: :end_city_id
end
