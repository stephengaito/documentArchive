Feature: provide default behaviour module

  In order to display content
  The administrator
  Wants to provide a defaul module

  @tbt
  Scenario: load and use default module
    When we get /show/test
    Then the result should contain default content class
