require "rails_helper"

describe Seeds::Prepare, :aggregate_failures do
  let(:carrier) { "\"Павлюк Виталий Иванович\" ФЛП" }
  let(:city_1) { "Киев" }
  let(:city_2) { "Львов" }
  let(:currency) { "RUB" }
  let(:station_1) { "Автостанция \"Киев\"" }
  let(:station_2) { "г. Львов, автостанция № 8" }
  let(:total_cost) { "687.93" }
  let(:date) { "15.05.2017" }

  let(:hash_1) do
    {
      start_city_name: city_1,
      station_begin_name: station_1,
      start_date: date,
      start_time: '01:00',
      end_city_name: city_2,
      station_end_name: station_2,
      end_date: date,
      end_time: '09:00',
      carrier_name: carrier,
      total_cost: total_cost,
      currency: currency
    }
  end

  let(:hash_2) do
    {
      start_city_name: city_1,
      station_begin_name: station_1,
      start_date: date,
      start_time: '06:30',
      end_city_name: city_2,
      station_end_name: station_2,
      end_date: date,
      end_time: '14:30',
      carrier_name: carrier,
      total_cost: total_cost,
      currency: currency
    }
  end

  let(:hash_3) do
    {
      start_city_name: city_1,
      station_begin_name: station_1,
      start_date: date,
      start_time: '09:00',
      end_city_name: city_2,
      station_end_name: station_2,
      end_date: date,
      end_time: '17:00',
      carrier_name: carrier,
      total_cost: total_cost,
      currency: currency
    }
  end

  let(:hash_4) do
    {
      start_city_name: city_1,
      station_begin_name: station_1,
      start_date: date,
      start_time: nil,
      end_city_name: city_2,
      station_end_name: station_2,
      end_date: date,
      end_time: '17:00',
      carrier_name: carrier,
      total_cost: total_cost,
      currency: currency
    }
  end

  context "call" do
    before do
      described_class.call(hash_1)
      described_class.call(hash_2)
      described_class.call(hash_3)
    end

    it "filled database" do
      expect(Carrier.sorted.pluck(:name)).to include(carrier)
      expect(City.sorted.pluck(:name)).to include(city_1, city_2)
      expect(Currency.sorted.pluck(:name)).to include(currency)
      expect(Station.sorted.pluck(:name)).to include(station_1, station_2)

      expect(Trip.sorted.size).to eq(3)
      expect(TripItem.sorted.size).to eq(3)
    end

    it "return if values have nil" do
      described_class.call(hash_4)
      expect(Trip.sorted.size).to eq(3)
      expect(TripItem.sorted.size).to eq(3)
    end
  end
end
