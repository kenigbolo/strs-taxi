class ComputeDistanceBetween

  def initialize(loc1, loc2)
    # Computation using Haversine formula
    rad_per_deg = Math::PI/180  # PI / 180
    rad_in_km = 6371                  # Earth radius in kilometers
    rad_in_m = rad_in_km * 1000             # Radius in meters

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rad_in_m * c # Delta in meters
  end

end
