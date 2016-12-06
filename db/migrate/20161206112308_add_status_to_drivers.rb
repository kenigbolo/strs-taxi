class AddStatusToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :status, :string
  end
end
