#create customers account

Given(/^I am in the customer home page$/) do
    visit path_to 'http://localhost:8100/#/bookings/new'
end

When(/^I provide my user name, password and phone number$/) do
  # Write code here that turns the phrase above into concrete actions
  end

When(/^my phone number contains (\d+) digits$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on register button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should get the message “User Registration Successful”$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^log me into the STRS homepage$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

# User Sign In

When(/^i provide my registered username$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^user password$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on the login button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^i should see my home page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

# user Sign output

When(/^i provide my registered user name$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on the sign out button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^STRS signs me out$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^takes me to the login page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
