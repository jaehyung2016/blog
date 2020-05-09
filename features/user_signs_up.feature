@javascript
Feature: User signs up
  As a user
  I want to sign up for the blog
  So that I can post an article

  Background: Reading an article
    Given I am reading an article

  Scenario: Sign up for the blog successfully
    When I sign up for the blog
    Then I should see a notice message for successful sign-up
    And I should be still on the same web page

  Scenario: Sign up with an existing email address
    When I try to sign up with an existing email
    Then I should see an error message for sign-up failure
