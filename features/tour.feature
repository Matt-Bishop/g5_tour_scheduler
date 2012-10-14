Feature: User can request a tour
  As a user
  In order to schedule a tour
  I want to be able to fill out a form
  
  Scenario: User can create a tour request (The full process)
    Given I visit the site
    When I enter an email
    Then I should be given notification that an email was sent
      And "homer@simpson.com" should receive 1 email
    When I open the email
      And I should see "Click to continue scheduling a tour" in the email body
    When I visit the link provided in the email
    Then I should be presented with a contact information form
    When I fill out the contact information
    Then I should be presented with a tour info form
    When I fill out the tour info form
    Then I should see a success message
      And "homer@simpson.com" should receive 1 email
      And "tours@example.com" should receive 1 email
    When "homer@simpson.com" opens the email with subject "Thank you for requesting a tour"
    Then the tour request info should be there but not the ip address 
    When "tours@example.com" opens the email with subject "A tour has been scheduled"
    Then the tour request info should be there with the ip address
    When I visit the link provided in the email
    Then I should see a ratings form 
      And I should see my info
    When I fill out the ratings form
    Then I should see a thank you message   
    
  Scenario: User must input a valid email 
    Given I visit the site
    When I don't enter an email
    Then I should see "Email can't be blank" 
    When I enter a bad email
    Then I should see "Email is invalid"
    
  Scenario: User must enter name and phone number
    Given I visit the site
    When I enter an email
      And I visit the link provided in the email
      And I click continue
    Then I should be at the same edit form
    When I enter the information
    Then I should be allowed to move on