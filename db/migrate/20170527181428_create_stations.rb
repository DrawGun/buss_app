class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.references :city

      t.timestamps
    end
  end
end
