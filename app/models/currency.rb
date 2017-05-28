class Currency < ApplicationRecord
  include CleanNameWithValidation
  include AvailableCollection
  include DefaultScopes

  has_many :trip_items, inverse_of: :currency
end
