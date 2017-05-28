module AvailableCollection
  extend ActiveSupport::Concern

  class_methods do
    def available_collection(name_only: false)
      cities = self.sorted

      if name_only
        cities.pluck(:name)
      else
        cities.pluck(:id, :name).map { |arr| [arr[1], arr[0]] }
      end
    end
  end
end
