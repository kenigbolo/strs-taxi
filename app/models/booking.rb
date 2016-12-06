class Booking < ApplicationRecord
  belongs_to :location
  AVAILABLE = "Available"
  CLOSED = "Closed"
end
