module Helpers
  def authenticate_user(token)
    User.includes(:driver).find_by(token: token)
  end

  def returned_user(user)
    returned_user = {"data": {"id": user.id.to_s, "type": "users", "attributes": {"first-name": user.first_name, "last-name": user.last_name, "token": user.token, "email": user.email, "user-type": user.user_type}}}
  end

  def login
    user = FactoryGirl.create(:user)
    post :login, user: { email: user.email, password: user.password}
  end

  def create_booking
    user = FactoryGirl.create(:user)
    location = FactoryGirl.create(:location)
    post :create, {user: { token: user.token}, location: {id: location.id}}
  end

  def accept_response
    booking = FactoryGirl.create(:booking)
    user = FactoryGirl.create(:user)
    driver = FactoryGirl.create(:driver, user_id: user.id)
    post :accept, {user: {token: user.token}, booking:{id: booking.id}}
  end
end
