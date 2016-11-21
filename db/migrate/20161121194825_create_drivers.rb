class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :car_type
      t.string :plate_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
