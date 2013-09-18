Feature: simple JSON editor

  In order to input some semi-structured data
  The developer/power-user 
  wants to edit some simple JSON structures

  Scenario: visit a JSON item and edit it
    Given FandianPF is running on port 8080
    When http://localhost:8080/json/testJson is visited
    Then a JSON editor will appear

  Scenario: visit a JSON item, edit it, and save it
    Given FandianPF is running on port 8080
    When http://localhost:8080/json/testJson is visited
     and edited
     and saved
    Then revisiting http://localhost:8080/json/testJson reflects changes
