module DefaultScopes
  extend ActiveSupport::Concern

  included do
    scope :sorted, -> { order(id: :asc) }
  end
end
