module Api
  class LocationsController < ApiController
    require 'google_distance_matrix.rb'
    require 'google_geocoding.rb'
    before_action :set_location, only: [:show, :update, :destroy]

    # GET api/locations
    def index
      @locations = Location.all

      render json: @locations
    end

    # GET api/locations/1
    def show
      render json: @location
    end

    # POST api/locations
    def create
      src_latlong = locator(location_params[:pickup_address])
      dst_latlong = locator(location_params[:dropoff_address])
      src_address = formatted_address(location_params[:pickup_address])
      dst_address = formatted_address(location_params[:dropoff_address])

      if !(src_latlong.empty? || dst_latlong.empty?)
        distance_between = calculate_distance(src_latlong, dst_latlong)
        time = calculate_time(src_latlong, dst_latlong)
        cost = calculate_cost(distance_between)

        location_details = {
          pickup_address: src_address,
          pickup_lat: src_latlong['lat'],
          pickup_long: src_latlong['lng'],
          dropoff_address: dst_address,
          dropoff_lat: dst_latlong['lat'],
          dropoff_long: dst_latlong['lng'],
          distance_between: distance_between,
          time: time,
          cost: cost
        }

        @location = Location.new(location_details)

        if @location.save
          render json: @location, status: :created
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      else
         render json: { error: 'Location Not Found, Please try again!' }, status: 404
      end
    end

    # PATCH/PUT api/locations/1
    def update
      if @location.update(location_params)
        render json: @location
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/locations/1
    def destroy
      @location.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        begin
          @location = Location.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Location Not Found" }, status: 404
        end
      end

      def locator(address)
        coord = Hash.new
        result = GoogleGeocoding.new(address)
        loc = result.get_coord
        if loc['status'] == "OK"
          res_arr = loc['results'][0]
          coord = res_arr['geometry']['location']
        else
          coord
        end
      end

      def formatted_address(address)
        result = GoogleGeocoding.new(address)
        loc = result.get_coord
        if loc['status'] == "OK"
          res_arr = loc['results'][0]
          res_arr['formatted_address']
        end
      end

      def calculate_distance(src, dst)
        result = GoogleDistanceMatrix.new(src, dst)
        dst_matrix = result.get_distance_matrix
        if dst_matrix['status'] == "OK"
          ele1 = result.get_distance_matrix['rows'][0]
          ele2 = ele1['elements']
          time = ele2[0]['distance']
          time['text']
        end
      end

      def calculate_cost(distance_between)
        # Assumption: We charge 2 euros per mile
        distance_between.delete(' km').to_f * 2
      end

      def calculate_time(src, dst)
        result = GoogleDistanceMatrix.new(src, dst)
        dst_matrix = result.get_distance_matrix
        if dst_matrix['status'] == "OK"
          ele1 = result.get_distance_matrix['rows'][0]
          ele2 = ele1['elements']
          time = ele2[0]['duration']
          time['text']
        end
      end

      # Only allow a trusted parameter "white list" through.
      def location_params
        params.permit(:pickup_address, :dropoff_address, :pickup_lat, :pickup_long, :dropoff_lat, :dropoff_long, :distance_between, :cost, :time)
      end
  end
end
