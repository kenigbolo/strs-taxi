Feature:  Taxi selection
          As a customer
          So that I can have a taxi booking confirmed
          I want one taxi to be selected

@JavaScript
Scenario:     Closest taxi
              Given that we have two taxi available one by "Kaubamaja" and the other at "Lounakeskus"
              And I submit a booking request
              Then I should receive a confirmation from the taxi close to "Kaubamaja"
              And I should also receive a delay estimate

Scenario: Most available taxi
          Given that are two taxi available, at the same distance with respect to L iivi
          When I request for any taxi
          Then I should receive a confirmation with the taxi that has been available the longest
          And I should receive a delay estimate

Scenario: Taxi driver rejects booking
          When taxi next to Kaubamaja rejects the booking
          Then STRS should be resent to the taxi at Lounakeskus

Scenario: Request timeout
          When STRS sends the booking request to the taxi next to Kaubamaja
          And the driver does not reply before 30 seconds
          Then STRS should select the taxi the next available taxi
