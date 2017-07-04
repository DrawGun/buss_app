class CreateTripItems < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_items do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :trip, null: false

      t.timestamps
    end
  end
end
