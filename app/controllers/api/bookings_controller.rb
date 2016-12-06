class BookingsController < ApiController

  def create
    booking = Booking.create(location_id: params[:location][:id], status: Booking::AVAILABLE)
    drivers = Driver.find_by(status: Driver::Active)
    drivers.each do |driver|
      Pusher.trigger('driver_#{driver.id}', 'ride', {
        start_location: booking.location.pickup_address,
        destination: booking.location.dropoff_address
      })
    end
  end

  def accept
    booking = Booking.find_by(id: params[:booking][:id])
    driver = User.find_by(token: params[:user][:token]).driver
    if booking && driver
      if booking.status != Booking::CLOSED
        booking.status = Booking::CLOSED
        booking.driver_id = driver.id
        driver.status = Driver::BUSY
        booking.save && driver.save
      else
        render json: {message: "Another driver is on the way"}
      end
    end
  end
end
