class City < ApplicationRecord
  validates :name, presence: true

  def name=(value)
    self[:name] = value.to_s.strip
  end
end
