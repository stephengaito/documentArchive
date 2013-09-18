Feature: install all dependencies

  In order to run FandianPF
  The server admin
  wants to install all requied dependencies

  Scenario: install <rubyType> <serverType> dependencies
    Given <rubyType> is installed
      and bundler is installed
    When rake dependencies:<serverType> command is invoked
    Then all non-ruby <serverType> dependencies will be installed
    | rubyType | serverType |
    | Ruby     | prod       |
    | Ruby     | dev        |
    | Rubinius | prod       |
    | Rubinius | dev        |
    | jRuby    | prod       |
    | jRuby    | dev        |
