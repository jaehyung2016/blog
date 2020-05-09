@javascript
Feature: User logs in and out
  As a user
  I want to log in
  So that I can post an article

  Background: Reading an article
    Given I am reading an article

  Scenario: Log in successfully
    When I log in
    Then I should see my name in the menu bar
    And I should be still on the same web page

  Scenario: Log in with wrong information
    When I try to log in with wrong information
    Then I should see an error message for log-in failure

  Scenario: Log out
    When I log in
    And I log out
    Then I should be redirected to home page
    And I should not see my name in the menu bar
