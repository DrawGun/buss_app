class Site::TripSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :start_point, :total_sum, :end_point,
    :carrier_name, :activity

  def total_sum
    "#{object.total_cost} #{object.currency_name}"
  end
end
