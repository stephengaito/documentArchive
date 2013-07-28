Feature: configure data store

  In order to access persistent data
  The administrator
  Wants to configure how and where the data is stored in a RDBMS

  @tbt @no-clobber @announce
  Scenario: create Sqlite database when no configuration file found
    When a file named "config.yaml" should not exist
     And I run `fandianpf` interactively
     And I wait for stdout to contain "Listening on tcp"
     And I kill all processes
    Then a file named "db/fandianpf_development.sqlite" should exist


