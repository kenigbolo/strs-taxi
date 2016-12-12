Feature: 	Taxi Driver Invoice
        		As a Taxi driver
        		So that I can receive my invoices for the month
        		I want my invoices to be generated at the end of the month

Background:
            Given I am a Taxi driver
            And I have fulfilled the following orders

Scenario:	 Invoice notification
            When it is the end of the month
            Then I should receive notification about my invoices

Scenario: 	List pending invoices
            Given I have invoice(s) pending
            And I am on the STRS home page
            When I click on invoices link
            Then I should see the list of pending invoices

Scenario: 	No list for no pending invoice
            Given I do not have invoice pending
            When I click on the invoices link
            Then I should not see any pending invoices

Scenario: 	List paid invoices with status
            Given I am on the invoices page
            When I select "paid" from the filter list
            And I click filter
            Then I should see only paid invoices
