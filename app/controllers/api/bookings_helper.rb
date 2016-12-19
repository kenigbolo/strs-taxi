module Api::BookingsHelper
  require 'compute_distance_between.rb'

  def create_booking(user, location)
    Booking.create(location_id: location.id, status: Booking::AVAILABLE, user_id: user.id)
  end

  def push_to_next_driver(driver, booking)
    driver_list = []
    drivers = Driver.where("status = ? ", Driver::ACTIVE).where("id != ?", driver.id)
    location = Location.find_by(id: booking.location_id)
    create_drivers_list(drivers, driver_list, location)
    push_booking_to_drivers(driver_list, booking)
  end

  def push_booking_to_drivers(driver_list, booking)
    new_list = []
    driver_list.each do |driver|
      new_list.push('driver_'+ driver.id.to_s)
    end
    Pusher.trigger(new_list[0], 'ride', {
        action: 'new_booking',
        booking: {
            start_location: booking.location.pickup_address,
            destination: booking.location.dropoff_address,
            id: booking.id
        }
    })
  end

  def create_drivers_list(drivers, driver_list, location)
    drivers.each do |driver|
      if is_nearest_driver(driver, location) then
        driver_list.push("driver_#{driver.id}")
      end
    end
  end

  def is_nearest_driver(driver, location)
    # Nearest on a 3km radius
    cl = location
    dl = driver
    # dl = location # mocked as the driver current location not yet implemented

    loc1 = [cl.pickup_lat, cl.pickup_long]
    # loc2 = [dl.pickup_lat, dl.pickup_long]
    loc2 = [dl.current_location_lat, dl.current_location_long]
    compute = ComputeDistanceBetween.new(loc1, loc2)
    #if (compute.get_distance <= 3000.0) then true else false end
    true
  end

  def push_status_to_user(booking, driver)
    Pusher.trigger("user_#{booking.user_id}", 'pickup', {
      message: "Your taxi is enroute",
      car_model: driver.car_model,
      car_color: driver.car_color,
      plate_number: driver.plate_number
    })
  end

  def update_status(booking, driver)
    booking.status = Booking::CLOSED
    booking.driver_id = driver.id
    driver.status = Driver::BUSY
    booking.save && driver.save
  end
end
