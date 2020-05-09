Feature: User updates account information
  As a user
  I want to update my account information
  So that I can keep my account up-to-date and secure

  @javascript
  Scenario: View and update account information, then delete account
    Given I am reading an article
    And I am logged in
    When I open My Account page
    Then I should see current account information
    When I update account information
    Then I should see updated account information
    And I should see a notice message for successful update of account information
    When I delete my account
    Then my account should not exist any more
    And my articles should not exist any more
    And I should be logged out
