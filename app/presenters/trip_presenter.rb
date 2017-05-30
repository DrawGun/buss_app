module TripPresenter
  def description
    "#{start_city_name}, #{station_begin_name} - #{end_city_name}, #{station_end_name}"
  end

  def activity
    if daily?
      "Ежедневно"
    else
      str = []
      Trip::SCHEDULE.each do |d_sym, d_str|
        str << d_str if self[d_sym]
      end

      str.join(", ")
    end
  end

  def start_point
    "#{start_city_name}, #{station_begin_name}"
  end

  def end_point
    "#{end_city_name}, #{station_end_name}"
  end
end
