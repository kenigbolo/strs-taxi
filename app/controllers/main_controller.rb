class MainController < ApplicationController
  def index
    output = {'message' => 'Welcome to STRS Taxi App'}.to_json
    render :json => output
  end
end
