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
      Seeds::Prepare.call(hash)
    end
  end
end

Seeds::CalculateSchedule.call()
