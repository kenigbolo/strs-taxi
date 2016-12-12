require 'rails_helper'

RSpec.describe Driver, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:driver)).to be_valid
    end
  end

  context "when a driver is created" do
    let(:driver) { FactoryGirl.build :driver}

    it "is a new driver object" do
      expect(driver).to be_a_new(Driver)
    end

    it "should be a valid driver object" do
      expect(driver).to be_valid
    end

    it "is expected to save driver properly" do
      expect(driver.car_model).not_to be_nil
      expect(driver.car_color).not_to be_nil
      expect(driver.plate_number).not_to be_nil
    end
  end
end
