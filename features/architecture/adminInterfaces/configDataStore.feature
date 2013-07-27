Feature: configure data store

  In order to access persistent data
  The administrator
  Wants to configure how and where the data is stored in a RDBMS

  @tbt
  Scenario: create Sqlite database when no configuration file found
    When a file named "config.yaml" should not exist
     And I run `fandianpf`
    Then a file named "db/fandianpf.sqlite" should exist


