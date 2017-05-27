class Station < ApplicationRecord
  include CleanNameWithValidation

  belongs_to :city, inverse_of: :stations

  validates :city, presence: true
end
