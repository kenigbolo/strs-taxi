require 'rails_helper'

RSpec.describe User, type: :model do
  email = Faker::Internet.email
  first_name = Faker::Name.name
  last_name = Faker::Name.name
  date_of_birth = Faker::Date.between(100.years.ago, 18.years.ago)

  user = User.new
	user.first_name = first_name
  user.last_name = last_name
	user.email = email
  user.dob = date_of_birth
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.save!(validations: false)

	new_user = User.new

  context 'When a new User is initialized' do
    it 'is a new user initialized' do
      expect(new_user).to be_a_new(User)
    end

    it 'should not be a valid User object when not saved' do
      expect(new_user).to_not be_valid
    end
  end

  context 'When a User details are saved' do
    it 'is expected to save a user object' do
      expect(user).to be_a(User)
    end

    it 'should be a valid User object' do
      expect(user).to be_valid
    end
  end
  it 'is expected to save the required user properties as defined' do
    expect(user.first_name).to eq(first_name)
    expect(user.last_name).to eq(last_name)
    expect(user.dob).to eq(date_of_birth)
    expect(user.email).to eq(email)
  end
  it 'uses bcrypt to generate a password digest for securing the password' do
  	expect(user.password_digest).to_not be_nil
  end
  it 'uses generates a secure token for authentication' do
    expect(user.token).to_not be_nil
  end
end
