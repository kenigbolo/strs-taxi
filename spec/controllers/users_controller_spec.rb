require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Api::UsersController, type: :controller do
  it "has access to the helper method (authenticate_user) defined in the module" do
    user = FactoryGirl.create(:user)
    expect(authenticate_user(user.token)).to eq(user)
  end

  it "has access to the helper method (returned_user) defined in the module" do
    user = FactoryGirl.create(:user)
    expect(returned_user(user)).to eq(returned_user(user))
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
      expect(response.body).to eq "Welcome to STRS-TAXI, please login to continue"
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
      error_message = { error: 'Inavalid email and/or passowrd' }
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

  describe "GET #logout" do
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
      user = FactoryGirl.build(:user)
      post :create, user: registration_params(user)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "returns a valid user details for valid login" do
      user = FactoryGirl.build(:user)
      post :create, user: registration_params(user)
      expect(response.body).to eq "Your registration was successfully, sign in to use our service"
    end

    it "returns an error message for incomplete parameters" do
      post :create, user: { email: "anyemail@email.com", password: "user_password", user_type: "Blaaaaah"}
      expect(response.body).to eq "We could not create an account for you.Please try again"
    end
  end

end
