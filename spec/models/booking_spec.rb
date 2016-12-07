require 'rails_helper'

RSpec.describe Booking, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:booking)).to be_valid
    end
  end

  context "when a booking is created" do
    let(:booking) { FactoryGirl.build :booking}

    it "is a new booking object" do
      expect(booking).to be_a_new(Booking)
    end

    it "should be a valid booking object" do
      expect(booking).to be_valid
    end

    it "is expected to save booking properly" do
      expect(booking.user_id).not_to be_nil
      expect(booking.location_id).not_to be_nil
      expect(booking.status).not_to be_nil
    end
  end
end
