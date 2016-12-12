FactoryGirl.define do
  factory :driver do
    car_model {Faker::StarWars.character}
    car_color {Faker::Color.color_name}
    plate_number {Faker::StarWars.droid}
    status "Active"
    user
  end
end
