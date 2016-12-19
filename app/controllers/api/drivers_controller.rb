module Api
  class DriversController < ApiController
    def login
	    logger.debug
      user = User.find_by(email: params[:user][:email])#.try(:authenticate, params[:user][:password])
      if user
        driver = Driver.find_by(user_id: user.id)
        if driver
          render json: {data: {user: user, driver: driver}}, status: 200
        else
          render json: {error: 'Driver does not exist'}, status: 404
        end
      else
        render json: { error: 'Invalid Username and/or Password'}, status: 404
      end
    end

    def logout
      user = User.find_by(token: params[:user][:token])
      driver = Driver.find_by(user_id: user.id)
      if driver
        driver.status = Driver::INACTIVE
        driver.save
      else
        render json: {error: 'Driver does not exist'}, status: 404
      end
      session[:current_user_id] = nil
      render json: { message: "successfully logged out!"}, status: 200
    end

    def update
      first_name = params[:user][:first_name]
      last_name = params[:user][:last_name]
      dob = params[:user][:dob]
      car_color = params[:driver][:car_color]
      car_model = params[:driver][:car_model]
      plate_number = params[:driver][:plate_number]
      user = User.find_by(token: params[:user][:token])
      if user
        driver = Driver.find_by(user_id: user.id)
        if driver
          user.first_name = first_name
          user.last_name = last_name
          user.dob = dob
          driver.car_color = car_color
          driver.car_model = car_model
          driver.plate_number = plate_number
          user.save
          driver.save
          render json: { status: 'success'}, status: 200
        else
          render json: {error: 'We could not find a registered driver account'}, status: 404
        end
      else
        render json: {error: 'No registered user'}, status: 404
      end
    end

    def status
      user = User.find_by(token: params[:user][:token])
      if user
        driver = Driver.find_by(user_id: user.id)
        if driver
          new_status = set_status(params[:driver][:status])
          if new_status.nil?
            render json: { error: 'Unknown status was provided' }, status: 200
          else
            if driver.save
              render json: { status: 'success' }, status: 200
            else
              render json: { error: 'Something went wrong while we tried to update your status, please try again' }, status: 200
            end
          end
        else
          render json: {error: 'Details could not be loaded'}, status: 404
        end
      else
        render json: { error: 'You are not authorized to perform this action' }, status: 404
      end

    end

    def location_set
      token = params[:user][:token]
      location_lat = params[:driver][:current_location_lat]
      location_long = params[:driver][:current_location_long]
      user = User.find_by(token: token)
      driver = Driver.find_by(user_id: user.id)
      if driver
        driver.current_location_lat = location_lat
        driver.current_location_long = location_long
        if driver.save
          render json: {message: "Your location #{location} has been successfully updated"}
        else
          render json: { error: "Locatin not updated"}, status: 404
        end
      else
        render json: { error: "Unauthorized"}, status: 404
      end
    end

    private
    def set_status(status)
      status = status.capitalize
      if status == Driver::ACTIVE
        Driver::ACTIVE
      elsif status == Driver::BUSY
        Driver::BUSY
      elsif status == Driver::TRANSIT
        Driver::TRANSIT
      elsif status == Driver::INACTIVE
        Driver::INACTIVE
      else
        NIL
      end
    end
  end
end
