module Api
  class UsersController < ApiController
    respond_to :json

    def create
      user = User.new
      user.first_name = params[user][first_name]
      user.last_name = params[user][last_name]
      user.email = params[user][email]
      user.dob = params[user][dob]
      user.password = params[password]
      user.password_confrimation = params[user][password_confrimation]
      user.user_type = params[user][user_type]

      if user.user_type == "Driver"
        save_driver(user)
      else
        save_user(user)
      end
    end

    def sign_in

    end

    private

    def user_reg_params
      params.require(:user).permit(:first_name, :last_name, :email, :dob, :password, :password_confrimation, :user_type, :car_type, :plate_number)
    end

    def save_user(user)
      if user.save!
        return user
      else
        respond_with
      end
    end

    def save_driver(user)
      user = save_user(user)
      if User.exists?(user.id)
        driver = Driver.new(user_id: user.id, car_type: params[user][car_type], plate_number: params[user][plate_number])
        if driver.save!
          respond_with "Your registration was successfully, sign in to use our service"
        else
          respond_with "We could not create an account for you.Please try again"
        end
      else
        respond_with "We could not create an account for you.Please try again"
      end
    end

  end
end
