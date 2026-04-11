Feature: Create Category
  As an authenticated user
  I want to create a category

  Background:
    Given I am on the home page

  Scenario: Authenticated user creates a category
    Given I am logged in as a user
    When I go to the new category page
    And I fill in name category
    And I click submit button
    Then I should be redirected to categories page
    And I should see a success message for "category"
