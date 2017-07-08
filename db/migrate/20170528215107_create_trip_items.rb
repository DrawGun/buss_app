class CreateTripItems < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_items do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :trip, null: false

      t.timestamps
    end
  end
end
