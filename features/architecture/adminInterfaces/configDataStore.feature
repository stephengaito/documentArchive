Feature: configure data store

  In order to access persistent data
  The administrator
  Wants to configure how and where the data is stored in a RDBMS

  @tbt @announce
  Scenario: create Sqlite database when no configuration file found
    Given The default aruba timeout is 10 seconds
    When a file named "config/settings.yml" should not exist
     And I run `fandianpf` interactively
     And I wait for stdout to contain "Listening on tcp"
     And I kill all processes
    #
    # FOR SOME REASON aruba is running fandianpf twice
    # AND it is running in development mode in tmp/aruba
    # HENCE we check for fandianpf_development.sqlite
    #
    Then a file named "db/fandianpf_development.sqlite" should exist


