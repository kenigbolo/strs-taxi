module Api
  class DriversController < ApiController
    def login
      user = User.find_by(email: params[:user][:email])#.try(:authenticate, params[:user][:password])
      if user
        driver = Driver.find_by(user_id: user.id)
        if driver
          render json: {user: user, driver: driver}, status: 200
        else
          render json: {error: 'Driver does not exist'}, status: 404
        end
      else
        render json: { error: 'Invalid Username and/or Password'}, status: 404
      end
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
        else
          render json: {error: 'We could not find a registered driver account'}, status: 404
        end
      else
        render jsn: {error: 'No registered user'}, status: 404
      end
    end

    def status
      user = authenticate_user(params[:user][:token])
      if user.user_type == User::DRIVER
        driver = user.driver
        driver.status = set_status(params[:driver][:status])
        if driver.save
          render json: { status: 'Your status has been successfully updated' }, status: 200
        else
          render json: { error: 'Something went wrong while we tried to update your status, please try again' }, status: 404
        end
      else
        render json: { error: 'You are not authorized to perform this action' }, status: 404
      end
    end

    def location_set
      token = params[:user][:token]
      location = params[:driver][:location]
      user = User.find_by(token: token)
      driver = Driver.find_by(user_id: user.id)
      if driver
        driver.current_location = location
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
      if status == 1
        Driver::ACTIVE
      elsif status == 2
        Driver::BUSY
      elsif status == 3
        Driver::TRANSIT
      else
        Driver::INACTIVE
      end
    end
  end
end
