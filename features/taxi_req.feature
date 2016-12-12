Feature: Request Taxi
         As a customer
         So that I can get a taxi ride
         then I should request for a taxi

@JavaScript
Scenario: Display form to request taxi
          Given that I click on the "request taxi" link
          Then I should see the form to request for taxi
          And I should see the following fields: "pickup address", "drop off address"

Scenario: Read location from GPS
          Given I am on the "request taxi" form
          And I can see the "use GPS location" link
          And my GPS location is available
          When i click on the "use GPS location" link
          Then my "pickup address" should be Liivi 2

Scenario: Validate request information
          Given I am on the "request taxi" form
          And I do not fill the following fields: "pickup address", "drop off address"
          When I click on request
          Then I should get an error to fill the required fields

Scenario: Send request for Taxi
          Given I am on the "request taxi" form
          And I fill "pickup address" with "Liivi 2"
          And I fill "drop-off address" with "Raatuse 22"
          When I click on request
          Then I should receive a notification that my request is being processed
