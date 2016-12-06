FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password 'PASSWORD'
    password_confirmation 'PASSWORD'
    dob {Faker::Date.between(50.years.ago, 18.years.ago)}
    token {SecureRandom.hex}
    user_type "Passenger"
  end
end
