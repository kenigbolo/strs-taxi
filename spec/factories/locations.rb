FactoryGirl.define do
  factory :location do
    pickup_address "MyString"
    dropoff_address "MyString"
    pickup_lat 1.5
    pickup_long 1.5
    dropoff_lat 1.5
    dropoff_long 1.5
    distance_between "MyString"
    cost 1.5
    time "MyString"
  end
end
