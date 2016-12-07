class Booking < ApplicationRecord
  belongs_to :location
  belongs_to :user
  AVAILABLE = "Available"
  CLOSED = "Closed"

  validates :location_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true, inclusion: [AVAILABLE, CLOSED]
end
