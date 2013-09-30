require 'support/aspec_helper';
require 'sequel';
require 'logger';

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
        # Connect to the database
        Dir.chdir('tmp/aruba') do
          db = Sequel.connect('sqlite://db/fandianpf_test.sqlite', 
                              logger: Logger.new(STDOUT) );
          # Ensure the security_events table exists
          expect(db.tables).to include :security_events;
          expect(db[:security_events].columns).to include :id
          expect(db[:security_events].columns).to include :description
          expect(db[:security_events].columns).to include :timeStamp
          expect(db[:security_events].order(:id).last[:description]).to match /Started FandianPF/

          # Ensure the json_objects table exists
          expect(db.tables).to include :json_objects;
          expect(db[:json_objects].columns).to include :id
          expect(db[:json_objects].columns).to include :jsonKey
          expect(db[:json_objects].columns).to include :jsonObject

          db.disconnect
        end
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
        # Connect to the database
        Dir.chdir('tmp/aruba') do
          db = Sequel.connect('sqlite://database/fpf_test.sql', 
                              logger: Logger.new(STDOUT) );
          expect(db.tables).to include :security_events;
          expect(db.tables).to include :json_objects;
          db.disconnect
        end
      end

    end
  end
end; end; end
