class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :start_city, null: false
      t.references :station_begin, null: false
      t.datetime :start_date, null: false
      t.references :end_city, null: false
      t.references :station_end, null: false
      t.datetime :end_date, null: false
      t.references :carrier, null: false
      t.decimal  :total_cost, precision: 10, scale: 2, default: 0.0, null: false
      t.references :currency, null: false

      t.timestamps
    end
  end
end
