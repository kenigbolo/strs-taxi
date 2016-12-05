class User < ApplicationRecord
	has_secure_password
	has_secure_token
	validates :email, presence: true, uniqueness: true
	validates :first_name, :last_name, :dob, :password, :password_confirmation, presence: true
	validates :password, :password_confirmation, :length => {:within => 6..40}

	def authenticate_user(token)
		User.include(:driver).find_by(token: token)
	end
end
