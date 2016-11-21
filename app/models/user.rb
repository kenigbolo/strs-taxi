class User < ApplicationRecord
	has_secure_password
	has_secure_token
	validates :email, presence: true, uniqueness: true
end

# {"user":{"first_name":"Meya"},{"last_name": "Kenigbolo"},{"email":"email@email.com"},{"password": "123456"},{"password_confirmation": "123456"},{"dob":"1991-05-27"},{},{},{},{},{}}
