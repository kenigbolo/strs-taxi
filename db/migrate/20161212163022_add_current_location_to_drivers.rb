class AddCurrentLocationToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :current_location, :float
  end
end
