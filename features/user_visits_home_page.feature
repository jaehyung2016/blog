Feature: User visits home page
  As a user
  I want to visit the blog home page
  So that I can read articles

  Scenario: View home page with 0 articles
    Given there are 0 articles
    When I visit the home page
    Then I should see index page indicating there are no articles
    But I should not see any articles

  Scenario: View home page with 5 articles
    Given there are 5 articles
    When I visit the home page
    Then I should see index page with 5 articles
    But I should not see pagination links

  Scenario: View home page with 6 articles
    Given there are 6 articles
    When I visit the home page
    Then I should see index page with 5 articles
    And I should see pagiation links with 2 pages
