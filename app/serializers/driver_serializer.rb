class DriverSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :car_color, :plate_number
end
