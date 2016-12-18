require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Api::UsersController, type: :controller do
  describe "Helper methods" do
    it "has access to the helper method (authenticate_user) defined in the module" do
      user = FactoryGirl.create(:user)
      expect(authenticate_user(user.token)).to eq(user)
    end

    it "has access to the helper method (returned_user) defined in the module" do
      user = FactoryGirl.create(:user)
      expect(returned_user(user)).to eq(returned_user(user))
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "renders a message for a user who is not logged in" do
      session[:current_user_id] = nil
      get :index
      welcome_message = {message: "Welcome to STRS-TAXI, please login to continue"}
      expect(response.body).to eq welcome_message.to_json
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
  end

  describe "POST #login" do
    it "returns http success" do
      login
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "returns a valid user details for valid login" do
      login
      user = User.find_by(id: session[:current_user_id])
      returned_user = returned_user(user)
      expect(response.body).to eq(returned_user.to_json)
    end

    it "returns a an error message for non existing email/password combination" do
      post :login, user: { email: "anyemail@email.com", password: "user_password"}
      error_message = { error: 'Invalid email and/or passowrd' }
      expect(response.body).to eq(error_message.to_json)
    end

    it "creates a session for the logged in user" do
      login
      expect(session[:current_user_id]).not_to eq(nil)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get :show, id: user.token
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "returns a valid user for valid token" do
      user = FactoryGirl.create(:user)
      get :show, id: user.token
      returned_user = returned_user(user)
      expect(response.body).to eq(returned_user.to_json)
    end
  end

  describe "POST #logout" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "logs out the current_user" do
      expect(session[:current_user_id]).to eq(nil)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      user_attributes = FactoryGirl.attributes_for(:user)
      post :create, { user: user_attributes }
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "returns a valid user details for valid login" do
      user_attributes = FactoryGirl.attributes_for(:user)
      post :create, { user: user_attributes }
      response_message = {status: "Your registration was successfully, sign in to use our service"}
      expect(response.body).to eq response_message.to_json
    end

    it "returns an error message for incomplete parameters" do
      post :create, user: { email: "anyemail@email.com", password: "user_password", user_type: "Blaaaaah"}
      error_message = {first_name: ["can't be blank"], last_name: ["can't be blank"], dob: ["can't be blank"], password_confirmation: ["can't be blank", "is too short (minimum is 6 characters)"]}
      expect(response.body).to eq error_message.to_json
    end
  end

  describe "POST #status" do

    before do
      user = FactoryGirl.create(:user, user_type: "Driver")
      driver = FactoryGirl.create(:driver, user_id: user.id)
      post :status, {user: {"token": user.token}, driver: {"status": 1}}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "Gives a successfully response for valid driver" do
      response_message = {status: "Your status has been successfully updated"}
      expect(response.body).to eq response_message.to_json
    end

    it "updates the drivers status to the given status update" do
      user = FactoryGirl.create(:user, user_type: "Driver")
      driver = FactoryGirl.create(:driver, user_id: user.id)
      expect(user.driver.status).to eq Driver::ACTIVE
    end

    it "Sets the response for any status which doesn't conform status constants to Inactive" do
      user = FactoryGirl.create(:user, user_type: "Driver")
      driver = FactoryGirl.create(:driver, user_id: user.id)
      post :status, {user: {"token": user.token}, driver: {"status": "ZZthieyrhs"}}
      expect(user.driver.status).to eq Driver::INACTIVE
    end

    it "Throws an error message for someone who isn't a driver" do
      user = FactoryGirl.create(:user)
      post :status, {user: {"token": user.token}, driver: {"status": "Active"}}
      response_message = {error: "You are not authorized to perform this action"}
      expect(response.body).to eq response_message.to_json
    end
  end

end
