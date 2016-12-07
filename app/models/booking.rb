class Booking < ApplicationRecord
  belongs_to :location
  AVAILABLE = "Available"
  CLOSED = "Closed"

  validates :location_id, presence: true
  validates :status, presence: true, inclusion: [AVAILABLE, CLOSED]
end
