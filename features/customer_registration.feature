Feature: Customer Registration
        	As a customer
        	So that I can use the taxi booking service of STRS
        	I want to create an account on the system
        	And provide my name and mobile number for subsequent bookings
@JavaScript
Scenario: create customers account
          Given that I am in the home page
          When I provide my user name, password and phone number
          And my phone number contains 11 digits
          And I click on register button
          Then I should get the message “User Registration Successful”
		      And log me into the STRS homepage

Scenario: New Sign in
          When i provide my registered user name
          And user password
          And I click on the login button
          Then i should see my home page

Scenario: user sign out
          then the message “Are you sure you want to sign out” is displayed
          When I click on the sign out button
          Then STRS signs me out
          And takes me to the login page
