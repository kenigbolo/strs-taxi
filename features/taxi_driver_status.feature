Feature: 	Taxi Driver Status
        		As a Taxi Driver
        		So that I can have my desired status
        		I want to set my desired status

Background:
                    	Given I am a Taxi Driver
                    	And my current status is "off-duty"

Scenario: 	Status display
            When I click on my account link
            Then my current status should indicate "off-duty"

Scenario: 	No order in status other than "available"
            Given I am in not in "available" status
            When a customer requests for a taxi
            Then I should not receive the request

Scenario: 	Set status
            When I click on the status link
            And I change the status to "available"
            And I click on save
            Then my current should be updated to "available"

Scenario: 	Receive request in "available" status
            Given my current status is "available"
            And I am the closest driver
            When a customer requests for a taxi
            Then I should receive the request
