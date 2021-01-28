Feature: Manage User Profile
  Scenario: Attendees can access the Manage Profile page directly from the Home page
    Given I am at the 'home_page'
    When I tap the 'manage_profile_btn' button
    Then I will be redirected to the 'manage_profile_page'
    And I will be presented with 'DISTRICT' and 'INTERESTS'
    And I will be able to save my profile by clicking the 'save_profile_btn'