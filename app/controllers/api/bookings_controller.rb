module Api
  class BookingsController < ApiController
    def create
      user = User.find_by(token: params[:user][:token])
      location = Location.find_by(id: params[:location][:id])
      booking = helpers.create_booking(user, location)
      drivers = Driver.where("status = ? ", Driver::ACTIVE)
      driver_list = []

      if booking && drivers.present?
        helpers.create_drivers_list(drivers, driver_list, location)
        helpers.push_booking_to_drivers(driver_list, booking)
        render json: {message: "Searching for available taxis..."}
      else
        render json: {message: "We do not have any available taxis. Try again in a few seconds"}
      end
    end

    def accept
      booking = Booking.find_by(id: params[:booking][:id])
      begin
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
      rescue ActiveRecord::RecordNotFound
        render json: {error: "Unauthorized"}, status: 404
      end
      if booking && driver
        if booking.status != Booking::CLOSED
          helpers.update_status(booking, driver)
          helpers.push_status_to_user(booking, driver)
          render json: {message: "Proceed to pickup location"}
        else
          render json: {message: "Another driver is on the way"}
        end
      else
        render json: {error: "Unauthorized"}, status: 404
      end
    end

    def start_ride
      begin
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
      rescue ActiveRecord::RecordNotFound
        render json: {error: "Unauthorized"}, status: 404
      end
      driver.status = Driver::TRANSIT
      driver.save
      render json: {status: "Status updated to #{driver.status}"}
    end

    def reject
      begin
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
        booking = Booking.find(params[:booking][:id])
      rescue ActiveRecord::RecordNotFound
        render json: {error: "Unauthorized"}, status: 404
      end
      driver.status = Driver::ACTIVE
      helpers.push_to_next_driver(driver, booking)
    end

    def invoice
      begin
        booking = Booking.find(params[:booking][:id])
      rescue ActiveRecord::RecordNotFound
        render json: {error: "We could not find that booking"}, status: 404
      end
      render json: {
        pickup: booking.location.pickup_address,
        dropoff: booking.location.dropoff_address,
        time: booking.location.time,
        total_cost: booking.location.total_cost
        }
    end

    def all_invoice
      user = User.find_by(token: params[:user][:token])
      driver = Driver.find_by(user_id: user.id)
      if driver
        bookings = Bookings.where("driver_id = ?", driver.id)
        render json: bookings
      end
    end

    def end_ride
      begin
        user = User.find_by(token: params[:user][:token])
        driver = Driver.find_by(user_id: user.id)
      rescue ActiveRecord::RecordNotFound
        render json: {error: "Unauthorized"}, status: 404
      end
      driver.status = Driver::ACTIVE
      driver.save
      render json: {status: "Status updated to #{driver.status}"}
    end
  end
end
