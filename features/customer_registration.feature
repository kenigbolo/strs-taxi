Feature: Customer Registration
        	As a customer
        	So that I can use the taxi booking service of STRS
        	I want to create an account on the system
        	And provide my name and mobile number for subsequent bookings
@JavaScript
Scenario: create customers account
          Given I am on the customer home page
          When I fill in "Victor" for "first_name"
          And I fill in "Aluko" for "last_name"
          And I fill in "victor@local.com for "email"
          And I fill in "123456" for "password"
          And I fill in "123456" for "confirmation_password"
          And I press "create"
          Then I should see “User Registration Successful”

Scenario: New Sign in
          Given I am on the customer home page
          When i provide my registered user name
          And user password
          And I click on the login button
          Then i should see my home page

Scenario: user sign out
          then the message “Are you sure you want to sign out” is displayed
          When I click on the sign out button
          Then STRS signs me out
          And takes me to the login page
