class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :start_city, null: false
      t.references :station_begin, null: false
      t.references :end_city, null: false
      t.references :station_end, null: false
      t.references :carrier, null: false
      t.string :activity, null: false, default: ""

      t.timestamps
    end
  end
end
