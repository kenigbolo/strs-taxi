class User < ApplicationRecord
	has_secure_password
	has_secure_token

	DRIVER = "Driver"

	has_one :driver
	has_many :bookings
	validates :email, presence: true, uniqueness: true
	validates :first_name, :last_name, :dob, :password, :password_confirmation, presence: true
	validates :password, :password_confirmation, :length => {:within => 6..40}

	def driver
		Driver.find_by(user_id: self.id)
	end
end
