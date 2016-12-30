Feature: User signs up
  As a user
  I want to sign up for the blog
  So that I can post an article

  @javascript
  Scenario: sign up for the blog
    Given I am reading an article
    When I sign up for the blog with email "john.doe@example.com"
    Then I should see "You have successfully signed up."
    And I am still on the same web page

  @javascript
  Scenario: sign up with an existing email address
    Given I am reading an article
    When I sign up for the blog with email "john.doe@example.net"
    Then I should see "Email john.doe@example.net is already registered."
