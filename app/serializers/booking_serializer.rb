class BookingSerializer < ActiveModel::Serializer
  attributes :id, :driver_id, :location_id, :user_id
end
