module AvailableCollection
  extend ActiveSupport::Concern

  class_methods do
    def available_collection(name_only: false)
      cities = self.sorted

      if name_only
        cities.pluck(:name)
      else
        cities.pluck(:name, :id)
      end
    end
  end
end
