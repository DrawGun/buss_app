class City < ApplicationRecord
  include CleanNameWithValidation

  has_many :stations, inverse_of: :city
end
