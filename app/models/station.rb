class Station < ApplicationRecord
  include CleanNameWithValidation
  include AvailableCollection
  include DefaultScopes

  belongs_to :city, inverse_of: :stations
  has_many :begin_trips, class_name: 'Trip', foreign_key: :station_begin_id
  has_many :end_trips, class_name: 'Trip', foreign_key: :station_end_id

  validates :city, presence: true
end
