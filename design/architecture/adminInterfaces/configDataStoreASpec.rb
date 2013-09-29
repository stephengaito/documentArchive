require 'support/aspec_helper';

module Fandianpf

# The Fandianpf::Architecture module collects the specifications of 
# architectural components of the FandianPF system.
module Architecture

# The Fandianpf::Architecture::AdminInterfaces module collects the 
# specifications of the AdminInterfaces.
module AdminInterfaces

  # The Fandianpf::Architecture::AdminInterfaces::ConfigDataStore 
  # module collects the integration specifications for the 
  # configuration of the persistent data store.
  module ConfigDataStore

    # Feature: configure data store
    describe ConfigDataStore do

      before(:each) do
        ignoreErrors { remove_file("config/settings.yml"); };
        ignoreErrors { remove_file("db/fandianpf_test.sqlite"); }
        ignoreErrors { remove_file("database/fpf_test.sql"); }
      end

      # 
      # In order to access persistent data
      # The administrator
      # Wants to configure how and where the data is stored in a RDBMS

      it "create Sqlite database when no configuration file found" do
        announceArubaSteps;
        # When a file named "config/settings.yml" should not exist
        # And a file named "db/fandianpf_test.sqlite" should not exist
        check_file_presence(["config/settings.yml", 
                             "db/fandianpf_test.sqlite"
                            ], false);
        # And I run fandianpf
        runFandianpf;
        # Then a file named "db/fandianpf_test.sqlite" should exist
        check_file_presence(["db/fandianpf_test.sqlite"], true);
        #
        # NOW check that the most important ("base") database tables exist
        #
        # When I run `sqlite3 db/fandianpf_test.sqlite "select * from security_events;"`
        run_simple(unescape('sqlite3 db/fandianpf_test.sqlite "select * from security_events;"'), true);
        # Then the stdout should contain "Started FandianPF"
        assert_partial_output("Started FandianPF", all_stdout);
      end

      it "create Sqlite database when configuration file found" do
        announceArubaSteps;
        # When I write to "config/settings.yml" with:
        settingsYaml = "sequelTestURI: sqlite:///./database/fpf_test.sql";
        write_file("config/settings.yml", settingsYaml);
        # And a file named "database/fpf_test.sql" should not exist
        check_file_presence(["database/fpf_test.sql"], false);
        # And I run fandianpf
        runFandianpf;
        # Then a file named "database/fpf_test.sql" should exist
        check_file_presence(["database/fpf_test.sql"], true);
        #
        # NOW check that the most important ("base") database tables exist
        #
        # When I run `sqlite3 database/fpf_test.sql "select * from fandianpf_security_events;"`
        run_simple(unescape('sqlite3 database/fpf_test.sql "select * from security_events;"'), true);
        # Then the stdout should contain "Started FandianPF"
        assert_partial_output("Started FandianPF", all_stdout);
      end

    end
  end
end; end; end
