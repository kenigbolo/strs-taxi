class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :pickup_address
      t.string :dropoff_address
      t.float :pickup_lat
      t.float :pickup_long
      t.float :dropoff_lat
      t.float :dropoff_long
      t.string :distance_between
      t.float :cost
      t.string :time

      t.timestamps
    end
  end
end
