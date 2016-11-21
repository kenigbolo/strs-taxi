module Api
  class UsersController < ApiController
    respond_to :json
    def create
      user = User.new(user_reg_params)
      if user.save!
        respond_with "Your registration was successfully, sign in to use our service"
      else
        respond_with "We could not create an account for you.Please try again"
      end
    end

    def sign_in

    end

    private
    def user_reg_params
      params.require(:user).permit(:first_name, :last_name, :email, :dob, :password, :password_confrimation, :user_type)
    end
  end
end
