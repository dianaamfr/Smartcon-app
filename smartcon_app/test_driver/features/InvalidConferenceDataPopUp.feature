Feature: Lacking Conference Information
  Scenario: A pop up is shown if conference data is incomplete
    Given I am at the Insert Conference Page
    When I fill the 'name_field' field with 'Conferencia Dummy'
    And I fill the 'description_field' field with 'This is a dummy conference'
    And I tap the 'insert_conference_next' button
    Then An 'invalid_conference_data' popup will show