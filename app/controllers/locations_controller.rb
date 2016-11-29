class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all

    render json: @locations
  end

  # GET /locations/1
  def show
    render json: @location
  end

  # POST /locations
  def create
    src_latlong = locator(location_params[:pickup_address])
    src_address = address(src_latlong)
    dst_latlong = locator(location_params[:dropoff_address])
    dst_address = address(dst_latlong)
    distance_between = calculate_distance(src_latlong, dst_latlong)
    time = calculate_time(src_latlong, dst_latlong)
    cost = calculate_cost(distance_between)

    location_details = {
      :pickup_address => src_address,
      :pickup_lat => src_latlong[0],
      :pickup_long => src_latlong[1],
      :dropoff_address => dst_address,
      :dropoff_lat => dst_latlong[0],
      :dropoff_long => dst_latlong[1],
      :distance_between => distance_between,
      :time => time,
      :cost => cost
    }

    @location = Location.new(location_details)

    if @location.save
      render json: @location, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      begin
        @location = Location.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render :json => {:error => "Record Not Found"}.to_json, :status => 404
      end
    end

    def locator(address)
      Geocoder.coordinates(address)
    end

    def address(latlong)
      coord = "#{latlong[0]},#{latlong[1]}"
      Geocoder.address(coord)
    end

    def calculate_distance(src, dst)
      result = GoogleDistanceMatrix.new(src, dst)
      ele1 = result.get_distance_matrix['rows'][0]
      ele2 = ele1['elements']
      time = ele2[0]['distance']
      return time['text']
    end

    def calculate_cost(distance_between)
      # Assumption: We charge 2 euros per mile
      distance_between.delete(' km').to_f * 2
    end

    def calculate_time(src, dst)
      result = GoogleDistanceMatrix.new(src, dst)
      ele1 = result.get_distance_matrix['rows'][0]
      ele2 = ele1['elements']
      time = ele2[0]['duration']
      return time['text']
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.permit(:pickup_address, :dropoff_address, :pickup_lat, :pickup_long, :dropoff_lat, :dropoff_long, :distance_between, :cost, :time)
    end
end
