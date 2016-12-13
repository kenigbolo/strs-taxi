class GoogleGeocoding
  include HTTParty
  base_uri 'maps.googleapis.com:443'

  def initialize(address)
    api_key = 'AIzaSyBG-Evxz-EMExbgZsXcW32FyMIG1iO-bbE'
    @options = { query: {address: address, key: api_key } }
  end

  def get_coord
    self.class.get("/maps/api/geocode/json?", @options)
  end
end
