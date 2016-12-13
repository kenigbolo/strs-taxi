class MainController < ApplicationController
  def index
    output = { message: 'Welcome to STRS Taxi App', status:200 }.to_json
    render :json => output
  end
end
