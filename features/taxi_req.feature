Feature: Request Taxi
         As a customer
         So that I can get a taxi ride
         then I should request for a taxi

@JavaScript
Scenario: Display form to request taxi
          Given that I click on the "request taxi" link
          Then I should see the form to request for taxi
          And I should see the following fields: "pickup address", "dropoff address"
