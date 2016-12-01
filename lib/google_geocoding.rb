class GoogleGeocoding
  include HTTParty
  base_uri 'maps.googleapis.com:443'

  def initialize(address)
    api_key = 'AIzaSyClrg3EWZzuhP9IcJFM1C0aNLgbCDDNc6w'
    @options = { query: {address: address, key: api_key } }
  end

  def get_coord
    self.class.get("/maps/api/geocode/json?", @options)
  end
end
