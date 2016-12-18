module Api
  class UsersController < ApiController

    def index
      if session[:current_user_id] == nil
        render json: {message: "Welcome to STRS-TAXI, please login to continue"}, status: 200
      end
    end

    def create
      logger.debug
	  user = User.new	  
      user.first_name = params[:user][:first_name]
      user.last_name = params[:user][:last_name]
      user.email = params[:user][:email]
      user.dob = params[:user][:dob]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.user_type = params[:user][:user_type]

      if user.user_type.capitalize == "Driver"
        save_driver(user)
      else
        save_user(user)
      end
    end

    def update
      first_name = params[:user][:first_name]
      last_name = params[:user][:last_name]
      dob = params[:user][:dob]
      user = User.find_by(token: params[:user][:token])
      if user
        user.first_name = first_name
        user.last_name = last_name
        user.dob = dob
        user.save
        render json: {message: 'successfully updated your profile'}, status: 200
      else
        render json: {error: 'could not update your profile, please try again'}, status: 404
      end
    end

    def show
      @user = authenticate_user(params[:id])
      render_user(@user)
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

    def login
      @user = User.find_by(email: params[:user][:email])#.try(:authenticate, params[:user][:password])
      render_user(@user)
    end

    def logout
      user = User.find_by(token: params[:user][:token])
      driver = Driver.find_by(user_id: user.id)
      if driver
        driver.status = Driver::INACTIVE
        driver.save
      end
      session[:current_user_id] = nil
      render json: { message: "successfully logged out!"}, status: 200
    end

    private
    def user_reg_params
      params.require(:user).permit(:first_name, :last_name, :email, :dob, :password, :password_confirmation, :user_type, :car_model, :car_color, :plate_number)
    end

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

    def authenticate_user(token)
      User.includes(:driver).find_by(token: token)
    end

    def save_user(user)
      if user.save
        render json: { status: 'Your registration was successfully, sign in to use our service' }, status: 200
      else
        render json: user.errors, status: 404
      end
    end

    def save_driver(user)
      user.save!
      if User.exists?(user.id)
        driver = Driver.new(status: Driver::INACTIVE, user_id: user.id, car_model: params[:user][:car_model], plate_number: params[:user][:plate_number], car_color: params[:user][:car_color])
        if driver.save!
          render json: { status: 'Your registration was successfully, sign in to use our service' }, status: 200
        else
          user.destroy
          render json: driver.errors, status: 404
        end
      else
        render json: { error: 'We could not create an account for you.Please try again' }, status: 404
      end
    end

    def render_user(user)
      if user
        if user.user_type == "Driver"
          session[:current_user_id] = @user.id
          render json: {user: user, driver_details: user.driver}
        else
          session[:current_user_id] = user.id
          render json: user
        end
      else
        render json: { error: 'Invalid email and/or passowrd' }, status: 404
      end
    end
  end
end
