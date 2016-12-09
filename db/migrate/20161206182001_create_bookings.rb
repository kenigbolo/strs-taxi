class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :driver_id
      t.references :location, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
