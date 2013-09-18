Feature: server admin configures Ruby based webserver

  In order to be able to run the Ruby based webserver
  The server admin
  wants to specify the various configuration parameters

  Scenario: webserver on port 8080 port open
    Given Ruby is installed
      and Puma is installed
      and Padrino is installed
    When the configuration file has port 8080
      and FandianPF is started
    Then the front page appears on http://localhost:8080

    

