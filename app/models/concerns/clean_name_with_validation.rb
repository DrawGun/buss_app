module CleanNameWithValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: true
  end

  def name=(value)
    self[:name] = value.to_s.strip
  end
end
