class GoogleDistanceMatrix
  include HTTParty
  base_uri 'maps.googleapis.com:443'

  def initialize(src_address, dst_address)
    api_key = 'AIzaSyC3Cn4TQ65le3CUUtc159kuDJ3_k_N41hw'
    src = src_address[0].to_s + ',' + src_address[1].to_s
    dst = dst_address[0].to_s + ',' + dst_address[1].to_s
    @options = { query: { units: 'metric', origins: src, destinations: dst, key: api_key } }
  end

  def get_distance_matrix
    self.class.get("/maps/api/distancematrix/json?", @options)
  end
end
