class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :start_city, null: false
      t.references :station_begin, null: false
      t.references :end_city, null: false
      t.references :station_end, null: false
      t.references :carrier, null: false

      t.decimal  :total_cost, precision: 10, scale: 2, default: 0.0, null: false
      t.references :currency, null: false

      t.boolean :monday, null: false, default: false
      t.boolean :tuesday, null: false, default: false
      t.boolean :wednesday, null: false, default: false
      t.boolean :thursday, null: false, default: false
      t.boolean :friday, null: false, default: false
      t.boolean :saturday, null: false, default: false
      t.boolean :sunday, null: false, default: false

      t.string :start_time, null: false
      t.string :end_time, null: false

      t.timestamps
    end
  end
end
