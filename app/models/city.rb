class City < ApplicationRecord
  include CleanNameWithValidation

  has_many :stations, inverse_of: :city

  scope :sorted, -> { order(id: :asc) }

  class << self
    def available_collection
      City.sorted.map { |c| [c.name, c.id] }
    end
  end
end
