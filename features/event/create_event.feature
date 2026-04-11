Feature: Create Event
  As an authenticated user
  I want to create an event

  Background:
    Given I am on the home page

  Scenario: Authenticated user creates an event
    Given I am logged in as a user
    And I have a category
    When I go to the new event page
    And I fill in name
    And I select category
    And I fill in date
    And I click submit button
    Then I should be redirected to events page
    Then I should see a success message for "event"
