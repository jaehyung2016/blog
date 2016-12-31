Feature: User logs in
  As a user
  I want to log in
  So that I can post an article

  @javascript
  Scenario: logs in
    Given I am reading an article
    When I log in with email "john.doe@example.net"
    Then I should see "John" in the menu bar

  @javascript
  Scenario: logs in with wrong information
    Given I am reading an article
    When I log in with email "john.doe@example.com"
    Then I should see "Invalid email/password"
