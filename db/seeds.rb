AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

filename = "trips.tar.gz"
trips_directory = "search_results"
tmp_file = Rails.root.join("tmp")
trips_file = Rails.root.join(filename)
filepath = "#{tmp_file}/#{trips_directory}"

system("tar -xvzf #{trips_file} -C #{tmp_file}")

Dir.foreach(filepath) do |fname|
  unless fname.in?(%w(. ..))
    YAML::load(File.open("#{filepath}/#{fname}")).each do |hash|
      unless hash.values.include?(nil)
        start_city = City.find_or_create_by(name: hash[:start_city_name].strip)
        station_begin = Station.find_or_create_by(city_id: start_city.id, name: hash[:station_begin_name].strip)
        end_city = City.find_or_create_by(name: hash[:end_city_name].strip)
        station_end = Station.find_or_create_by(city_id: end_city.id, name: hash[:station_end_name].strip)
        carrier = Carrier.find_or_create_by(name: hash[:carrier_name].strip)
        currency = Currency.find_or_create_by(name: hash[:currency].strip)

        trip = Trip.new(
          start_date: hash[:start_date],
          start_time: hash[:start_time],
          end_date: hash[:end_date],
          end_time: hash[:end_time],
          total_cost: hash[:total_cost]
        )

        trip.start_city = start_city
        trip.station_begin = station_begin
        trip.end_city = end_city
        trip.station_end = station_end
        trip.carrier = carrier
        trip.currency = currency

        trip.save
      end
    end
  end
end
