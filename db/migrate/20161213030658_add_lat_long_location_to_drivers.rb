class AddLatLongLocationToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :current_location_lat, :float
    add_column :drivers, :current_location_long, :float
  end
end
