Feature: Read Rss feeds
  In order to get rss feeds
  A user
  Should input valid url

  Scenario: View feeds for an input url
    Given I am on the home page
    Then I should see "Welcome to RSS feed reader"
    And I fill in "simplerssurl" with "https://www.ruby-lang.org/en/feeds/news.rss"
    Then show me the page
    When I press "submit_simplerssurl"

    Then I wait for "20" seconds
    Then I should see "Ruby News"
