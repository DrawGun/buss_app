class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :carriers, :name, unique: true
    add_index :cities, :name, unique: true
    add_index :currencies, :name, unique: true
    add_index :stations, [:name, :city_id], unique: true
    add_index :trips, [:start_time, :end_time, :total_cost, :start_city_id, :end_city_id, :station_begin_id, :station_end_id, :carrier_id], unique: true, :name => 'trip_common_index'
  end
end
