class Currency < ApplicationRecord
  include CleanName
  include AvailableCollection
  include DefaultScopes

  validates :name, presence: true, uniqueness: true

  has_many :trip_items, inverse_of: :currency
end
