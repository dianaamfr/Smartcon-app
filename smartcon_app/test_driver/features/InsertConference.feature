Feature: Insert conference data
  Scenario: Conference Staff can insert conference data
    Given I am at the 'home_page'
    When I tap the 'insert_conference_btn' button
    Then I will be redirected to the 'insert_conference_page'
    And I will be presented with 'name_field', 'district_field', 'description_field', 'category_field' and 'dates_field'