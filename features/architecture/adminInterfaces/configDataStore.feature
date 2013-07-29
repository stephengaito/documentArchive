Feature: configure data store

  In order to access persistent data
  The administrator
  Wants to configure how and where the data is stored in a RDBMS

  @aruba @announce
  Scenario: create Sqlite database when no configuration file found
    When a file named "config/settings.yml" should not exist
     And a file named "db/fandianpf_development.sqlite" should not exist
     And I run fandianpf
    #
    # FOR SOME REASON aruba is running fandianpf twice
    # AND it is running in development mode in tmp/aruba
    # HENCE we check for fandianpf_development.sqlite
    #
    Then a file named "db/fandianpf_development.sqlite" should exist
    When I run `sqlite3 db/fandianpf_development.sqlite "select * from fandianpf_security_events;"` interactively
     And I wait for stdout to contain "Started FandianPF"

  @tbt @aruba @announce
  Scenario: create Sqlite database when configuration file found
    When I write to "config/settings.yml" with:
      """
sqlitePath: database/fpf_test.sql
      """
     And a file named "database/fpf_test.sql" should not exist
     And I run fandianpf
    Then a file named "database/tpf_test.sql" should exist    
    When I run `sqlite3 database/tpf_test.sql "select * from fandianpf_security_events;"` interactively
     And I wait for stdout to contain "Started FandianPF"

