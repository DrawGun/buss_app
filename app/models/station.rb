class Station < ApplicationRecord
  include CleanNameWithValidation

  belongs_to :city, inverse_of: :stations

  validates :city, presence: true

  scope :sorted, -> { order(id: :asc) }

  class << self
    def available_collection
      Station.sorted.map { |c| [c.name, c.id] }
    end
  end
end
