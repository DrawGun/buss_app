class Carrier < ApplicationRecord
  include CleanName
  include AvailableCollection
  include DefaultScopes

  validates :name, presence: true, uniqueness: true

  has_many :trips, inverse_of: :carrier
end
