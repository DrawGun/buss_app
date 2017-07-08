module TripItemPresenter
  def start_datetime(date_format: "%d.%m.%Y")
    "#{start_date.strftime(date_format)} #{trip_start_time}"
  end

  def end_datetime(date_format: "%d.%m.%Y")
    "#{end_date.strftime(date_format)} #{trip_end_time}"
  end
end
