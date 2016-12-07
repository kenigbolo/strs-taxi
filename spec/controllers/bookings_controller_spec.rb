require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Api::BookingsController, type: :controller do
  describe "POST #create" do
    it "returns http success" do
      create_booking
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "returns a Returns a valid response for taxi unavailability" do
      create_booking
      message = { message: 'We do not have any available taxis. Try again in a few seconds' }
      expect(response.body).to eq(message.to_json)
    end
    # it "returns a Returns a valid response for successful taxi request" do
    #   create_booking
    #   message = { message: 'Searching for available taxis......' }
    #   expect(response.body).to eq(message.to_json)
    # end
    #
    # it "returns a an error message for invalid requests" do
    #   create_booking
    #   error_message = { error: 'Inavalid email and/or passowrd' }
    #   expect(response.body).to eq(error_message.to_json)
    # end
  end

end
