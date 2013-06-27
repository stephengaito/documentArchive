Feature: simple RESTful interface

  In order to up/down-load raw content
  The power-user 
  wants to up/down-load json content

  Scenario: download json content
    When we get json from '/testJson'
    Then testJson.json is downloaded

#  Scenario: upload json content
#    When we post test2Json.json to '/test2Json'
#     And we get json from '/test2Json'
#    Then test2Json.json is downloaded
