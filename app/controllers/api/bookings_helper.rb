module Api::BookingsHelper
  require 'compute_distance_between.rb'

  def create_booking(user, location)
    Booking.create(location_id: location.id, status: Booking::AVAILABLE, user_id: user.id)
  end

  def push_booking_to_drivers(driver_list, booking)
    Pusher.trigger(driver_list[0..9], 'ride', {
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
    dl = driver.current_location
    loc1 = [cl.pickup_lat, cl.pickup_long]
    loc2 = [dl.pickup_lat, dl.pickup_long]
    distance = ComputeDistanceBetween.new(loc1, loc2)
    distance <= 3000.0 ? true : false
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
