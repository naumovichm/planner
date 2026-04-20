Feature: Home page
  As a user
  I want to visit the home page

  Background:
    Given I am on the home page

  Scenario Outline: Authenticated user on home page
    Given I am logged in as a user
    Then I should see a success message about successful sign in
    And I should see the navigation bar with "<link>" link
    And I should see "<text>"

    Examples:
      | link        | text                        |
      | Me          | You have events today       |
      | Events      | You have events in future   |
      | Categories  | Welcome                     |
