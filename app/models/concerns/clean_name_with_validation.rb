module CleanNameWithValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: true

    def name=(value)
      self[:name] = value.to_s.strip
    end
  end
end
