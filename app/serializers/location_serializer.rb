class LocationSerializer < ActiveModel::Serializer
  attributes :id, :pickup_address, :dropoff_address, :pickup_lat, :pickup_long, :dropoff_lat, :dropoff_long, :distance_between, :cost, :time
end
