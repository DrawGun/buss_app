class Site::TripItemSerializer < ActiveModel::Serializer
  attributes :id, :start_date_str, :end_date_str, :trip_description, :trip_carrier_name,
    :trip_start_point, :trip_end_point, :trip_activity, :total_sum

  def start_date_str
    object.start_date.strftime("%d.%m.%Y %H:%M")
  end

  def end_date_str
    object.end_date.strftime("%d.%m.%Y %H:%M")
  end

  def total_sum
    "#{object.total_cost} #{object.currency_name}"
  end
end
