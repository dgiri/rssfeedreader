Feature: Read Rss feeds
  In order to get rss feeds
  A user
  Should input valid url

  Scenario: View feeds for an input url
    Given I am on the home page
    Then I should see "RSS feed reader basic application"
    When I sign up with valid user data
    Then I should see "Welcome! You have signed up successfully."
    And I should see "Sign out"
    When I follow "Feeds"
    Then I should see "All Contents"
    And I follow "Add New URL"
    Then I fill in "rssfeed_feedurl" with "https://www.ruby-lang.org/en/feeds/news.rss"
    And I press "Submit"
    Then I should see "Ruby News"
