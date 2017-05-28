class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name, null: false
      t.references :city, null: false

      t.timestamps
    end
  end
end
