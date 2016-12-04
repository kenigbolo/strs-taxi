FactoryGirl.define do
  factory :driver do
    car_model {Faker::StarWars.character}
    car_color {Faker::StarWars.droid}
    plate_number {Faker::Number.hexadecimal(6)}
    user
  end
end
