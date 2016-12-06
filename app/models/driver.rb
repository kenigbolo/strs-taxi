class Driver < ApplicationRecord
  ACTIVE = "Active"
	BUSY = "Busy"
	INACTIVE = "Inactive"

  belongs_to :user
  validates :car_color, :car_model, :plate_number, :user_id, presence: true
  validates :status, presence: true, inclusion: [ACTIVE, BUSY, INACTIVE]
end
