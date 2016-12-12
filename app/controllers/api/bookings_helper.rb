module Api::BookingsHelper
  def create_booking(user, location)
    Booking.create(location_id: location.id, status: Booking::AVAILABLE, user_id: user.id)
  end

  def push_booking_to_drivers(driver_list, booking)
    Pusher.trigger(driver_list[0..9], 'ride', {
        action: 'new_booking',
        booking: {
            start_location: booking.location.pickup_address,
            destination: booking.location.dropoff_address,
            customer_first_name: booking.user.first_name
            customer_last_name: booking.user.last_name
            customer_phone_number: booking.user.phone_number
            id: booking.id
        }
    })
  end

  def create_drivers_list(drivers, driver_list)
    drivers.each do |driver|
      driver_list.push("driver_#{driver.id}")
    end
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
