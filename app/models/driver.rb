class Driver < ApplicationRecord
  ACTIVE = 'Active'
	BUSY = 'Busy'
  TRANSIT = 'Transit'
	INACTIVE = 'Inactive'
	INVISIBLE = 'Invisible'

  belongs_to :user
  validates :car_color, :car_model, :plate_number, :user_id, presence: true
  validates :status, presence: true, inclusion: [ACTIVE, BUSY, TRANSIT,INACTIVE,INVISIBLE]
end
