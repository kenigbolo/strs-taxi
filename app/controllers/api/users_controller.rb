module Api
  class UsersController < ApiController

    def create
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

    def login
      @user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
      if @user
        if @user.user_type == "Driver"
          session[:current_user_id] = @user.id
          render json: {user: @user, driver_details: @user.driver}
        else
          session[:current_user_id] = @user.id
          render json: @user
        end
      else
        render json: { error: 'Inavalid email and/or passowrd' }, status: 404
      end
    end

    def logout
      session[:current_user_id] = nil
    end

    private

    def user_reg_params
      params.require(:user).permit(:first_name, :last_name, :email, :dob, :password, :password_confirmation, :user_type, :car_model, :car_color, :plate_number)
    end

    def save_user(user)
      if user.save!
        render :plain => "Your registration was successfully, sign in to use our service"
      else
        render :plain => "We could not create an account for you.Please try again"
      end
    end

    def save_driver(user)
      user = user.save!
      if User.exists?(user.id)
        driver = Driver.new(user_id: user.id, car_model: params[:user][:car_model], plate_number: params[:user][:plate_number], color: params[:user][:color])
        if driver.save!
          render :plain => "Your registration was successfully, sign in to use our service"
        else
          user.destroy
          render :plain => "Something went wrong while trying to save your car details"
        end
      else
        render :text => "We could not create an account for you.Please try again"
      end
    end

  end
end
