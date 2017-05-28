class Carrier < ApplicationRecord
  include CleanNameWithValidation
  include AvailableCollection
  include DefaultScopes

  has_many :trips, inverse_of: :carrier
end
