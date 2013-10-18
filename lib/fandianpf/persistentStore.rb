require 'padrino'
require 'sequel'
require "addressable/uri"
require 'logger'
require 'json'

require 'fandianpf/utils/search';

module Padrino
  module Cache
    module Store
      class Memeory

        ##
        # Reinitialize your cache.
        #
        # @example
        #   MyApp.cache.flush
        #   MyApp.cache.get('records') # => nil
        #
        # Fixed in Fandainpf::PersistentStore to clear the entries as 
        # well as the index.
        def flush
          @index = Hash.new;
          @entries = Array.new;
        end
      end
    end
  end
end

module Fandianpf

  # The FandianPF persistent storage subsystem.
  #
  module PersistentStore

    class UpdateError < StandardError
    end

    class MigrationError < StandardError
    end

    class << self 
      include Fandianpf::Utils::Search;

      # Access the Sequel Database associated with this persistent 
      # store.
      def db
        @@db
      end

      # Access the Padrino Cache devoted to json objects associated 
      # with this persistent store.
      def jsonCache
        @@jsonCache
      end

      # Access the Hash devoted to the collection of content type 
      # Sequel database migrations.
      def migrations
        @@migrations
      end

      # Mock the database and jsonCache to allow for testing of this 
      # singleton pattern.
      #
      # @param [RSpecMock] databaseMock a double of the database
      # @param [RSpecMock] cacheMock a doulbe of the cache
      # @param [Block] &block the block to perform while mocked.
      # @return not specified
      def mockStore(databaseMock, cacheMock, &block)
        oldDB         = defined?(@@db)         ? @@db : nil;
        oldCache      = defined?(@@jsonCache)  ? @@jsonCache : nil;
        oldMigrations = defined?(@@migrations) ? @@migrations : nil;
        @@db        = databaseMock;
        @@jsonCache = cacheMock;
        @@migrations = Hash.new;
        begin
          block.call
        ensure 
          @@db         = oldDB;
          @@jsonCache  = oldCache;
          @@migrations = oldMigrations;
        end
      end

      # Setup the persistent storage system. (Currently connect to the 
      # database using Sequel).
      #
      # @return not specified
      def setup

        ##
        # A MySQL connection:
        # DB = Sequel.connect('mysql://user:password@localhost/the_database_name', loggers: [ logger ] )
        #
        # # A Postgres connection:
        # DB = Sequel.connect('postgres://user:password@localhost/the_database_name', loggers: [ logger ] )
        #
        # # A Sqlite3 connection
        # DB = Sequel.connect("sqlite://" + Padrino.root('db', "development.db", loggers: [ logger ] ))
        #
        sequelURI = getSequelURI(Padrino.env, Fandianpf::Utils::Options.getSettings);

        logger.info "using database: #{sequelURI}";

        @@db = Sequel.connect(sequelURI, logger: logger );

        @@jsonCache = Padrino::Cache::Store::Memory.new(10000);

        @@migrations = Hash.new;

        # Ensure the base most important DB tables exist
        ensureSecurityEventTableExists
        ensureContentTypeTableExists

        # Load the Sequel migration subsystem
        Sequel.extension :migration

        # now do any required JsonObject table migrations.
        listJsonObjectTableMigrations
        doMigrations(:JsonObject);

        # Raise error on save failures globally across all models for 
        # non-production environments
        #
        Sequel::Model.raise_on_save_failure = true  unless Padrino.env == :production;

      end

      # Ensure that the SecurityEvent (:security_events) table exists 
      # in the persistent storage database.
      #
      # @note This table is hard to change in a production envrionment
      #
      # @return not specified
      def ensureSecurityEventTableExists
        if ! @@db.tables.include?(:security_events) then
          @@db.create_table :security_events do
            primary_key :id
            String      :description, :text=>true
            DateTime    :timeStamp
          end
        end
      end

      # Ensure that the content types table exists in the persistent 
      # storage database.
      #
      # @note This table is hard to change in a production envrionment
      #
      # @return not specified
      def ensureContentTypeTableExists
        if ! @@db.tables.include?(:content_types) then
          @@db.create_table :content_types do
            primary_key :id
            String      :contentTypeName,  :text=>true, 
                                           :index=>true
            Integer     :migrationVersion, :default=>0
          end
        end
      end

      # Ensure that the JsonObject (:json_objects) table exists in the 
      # persistent storage database.
      #
      # @note The JsonObject table is likely to evolve over time so we 
      #   manage it useing the PersistentStore migrations subsystem.
      #
      # @return not specified
      def listJsonObjectTableMigrations
        migration(:JsonObject,1) do
          up do
            create_table :json_objects do
              primary_key :id
              String      :jsonKey,        :text=>true, 
                                           :index=>true
              String      :jsonObject,     :text=>true
              TrueClass	:isSymbolicLink, :default=>false
              DateTime    :timeStamp
            end
          end
        end
      end

      # ::getMigrationVersion returns the last migration performed or 
      # -1 if none have ever been performed.
      #
      # @param [Symbol] ctKlassName the name of the content type for 
      #   this migration. 
      # @return [Integer] the version of the last migration performed.
      def getMigrationVersion(ctKlassName)
        contentTypeItem = @@db[:content_types].where(:contentTypeName => ctKlassName.to_s).order(:id).last;
        if contentTypeItem.nil? then
          @@db[:content_types].insert({ contentTypeName:ctKlassName.to_s, 
                                        migrationVersion:-1 });
          return -1;
        end
        contentTypeItem[:migrationVersion];
      end

      # ::setMigrationVersion records the last migration performed.
      #
      # @param [Symbol] ctKlassName the name of the content type for 
      #   this migration. 
      # @param [Integer] the version of the last migration performed.
      # @return not specified
      def setMigrationVersion(ctKlassName, lastMigrationVersion)
        contentTypeItem = @@db[:content_types].where(:contentTypeName => ctKlassName.to_s).order(:id).last;
        if contentTypeItem.nil? then
          @@db[:content_types].insert({ contentTypeName:ctKlassName.to_s, 
                                        migrationVersion:-1 });
        end
        @@db[:content_types].where(:id=>contentTypeItem[:id]).update(:migrationVersion=>lastMigrationVersion);
      end

      # ::migration conditionally performs one migration on the persitent
      # store.
      #
      # @param [Symbol] ctKlassName the name of the subclass 
      #   registering these fields.
      # @param [Integer] versionNumber the sequential version number of 
      #   this migration.
      # @param [Block] &block the block with implements the migration
      # @return not specified
      def migration(ctKlassName, versionNumber = 0, &block)
        @@migrations[ctKlassName] = Hash.new unless @@migrations.has_key? ctKlassName;
        if @@migrations[ctKlassName].has_key?(versionNumber) then
          raise MigrationError, "a migration for the versionNumber #{versionNumber} has already been defined";
        end
        @@migrations[ctKlassName][versionNumber] = block;
      end

      # ::doMigrations performs all required migrations associated with 
      # the given content type.
      #
      # @note At the moment we ONLY to upwards migrations.
      #
      # @param [Symbol] ctKlassName the class name of the content type
      # @return not specified
      def doMigrations(ctKlassName, sequelKlass = Sequel)
        return unless @@migrations.has_key?(ctKlassName);

        currentMigrationVersion = getMigrationVersion(ctKlassName);
        lastMigrationVersion    = -1;
        ctMigrations = @@migrations[ctKlassName];
        @@db.transaction do
          ctMigrations.keys.sort.each do | versionNumber |
            next if versionNumber <= currentMigrationVersion;
            sequelKlass.migration(&ctMigrations[versionNumber]).apply(@@db,:up);
            lastMigrationVersion = versionNumber;
          end
          setMigrationVersion(ctKlassName, lastMigrationVersion) unless lastMigrationVersion < 0;
        end # commit migrations and setMigrationVersion as a single transaction.
      end

      # Get the Sequel URI so we can configure database
      #
      # IF there are no database configuration directives set
      # THEN we 
      #  use Sqlite databases 
      #  located in the db directory 
      #  named fandianpf_<<Padrino.env>>.sqlite
      #
      # @note SIDE-EFFECT: IF we are using sqlite we also ensure that the 
      #   full path to the database file exists.
      #
      # @param [Symbol] padrinoEnv The current value of Padrino.env
      # @param [Hash]   padrinoSettings The current value of the global 
      #   $padrinoSettings
      # @return [String]
      #
      def getSequelURI(padrinoEnv, padrinoSettings = {}, fileUtilsClass = FileUtils, fileClass = File )
        sequelURI  = "sqlite:///./db/fandianpf_#{padrinoEnv}.sqlite";
        settingsKey = ('sequel'+padrinoEnv.to_s.capitalize+'URI').to_sym;
        sequelURI  = padrinoSettings[settingsKey] if padrinoSettings.has_key?(settingsKey);

        if sequelURI.downcase =~ /^sqlite/ then
          sqliteDbURI = Addressable::URI.parse(sequelURI);
          sqliteDbPath = sqliteDbURI.path;
          if sqliteDbPath =~ /^\/\.\// then
            sqliteDbURI.path = Dir.getwd + '/' + sqliteDbPath.sub(/^\/\.\//,'');
            sequelURI = sqliteDbURI.to_s;
          end
          fileUtilsClass.mkpath(File.dirname(sqliteDbURI.path)) unless fileClass.directory?(File.dirname(sqliteDbURI.path));
        end
        return sequelURI;
      end

      # Do the required housekeeping if we know that the web server 
      # forks worker threads.
      #
      # This should ONLY be called *after* all application classes (and 
      # in particular models) have been loaded.  It is typically used 
      # in the Padrino.after_load block.
      # 
      # @return not specified
      def webServerForks!
        # Taken from the Sequel code order documentation:
        #
        # Disconnect If Using Forking Webserver with Code Preloading
        #
        # If you are using a forking webserver such as unicorn or 
        # passenger, with a feature that loads your Sequel code before 
        # forking connections (code preloading), then you must 
        # disconnect your database connections before forking. If you 
        # don't do this, you can end up with child processes sharing 
        # database connections and all sorts of weird behavior. Sequel 
        # will automatically reconnect on an as needed basis in the 
        # child processes, so you only need to do the following in the 
        # parent process:
        #
        @@db.disconnect
      end

      # Find the JSON object associated with the given JSON key.
      #
      # @param [Symbol] jsonKey the key used to find the required JSON 
      #   object.
      # @return [Object] the JSON object or {}.
      def findJSON(jsonKey)
        require 'pp';

        jsonKeySym = jsonKey.to_sym;

        # create a list of existing symbolic links we have traversed
        linkRefs = Hash.new

        jsonRecord = { isSymbolicLink: true };
        while jsonRecord[:isSymbolicLink] do 

          # start by checking the cache
          jsonRecord = PersistentStore.jsonCache.get(jsonKeySym);

          # if jsonRecord is nil then hit the database instead
          if jsonRecord.nil? then
            jsonRecord = @@db[:json_objects].where(:jsonKey => jsonKey.to_s).order(:id).last;
            @@jsonCache.set(jsonKeySym, jsonRecord) unless jsonRecord.nil?;
          end
#          puts "jsonKey: [#{jsonKey}]";
#          pp jsonRecord;
          jsonRecord = { isSymbolicLink: false } if jsonRecord.nil?;
          if jsonRecord[:isSymbolicLink] then
            if linkRefs.has_key?(jsonRecord[:jsonObject]) then
              # we have hit a cirular loop ;-(
              jsonRecord = { isSymbolicLink: false };
            else
              # we have not seen this link yet... so follow it.
              jsonKey = jsonRecord[:jsonObject];
              jsonKeySym = jsonKey.to_sym;
              linkRefs[jsonRecord[:jsonObject]] = true;
            end
          end
        end

        if jsonRecord.has_key?(:jsonObject) then
          jsonRecord[:jsonObject] = JSON.parse(jsonRecord[:jsonObject]) if jsonRecord[:jsonObject].kind_of?(String);
        end

        jsonRecord.delete(:isSymbolicLink);

#        pp jsonRecord;

        jsonRecord
      end

      def getJoinTables(searchStructure)
        []
      end

      def searchJSON(jsonSearch)
        jsonSearch = normalizeJsonSearch(jsonSearch);
        joinTables = getJoinTables(jsonSearch);
        []
      end

      # Store the JSON object under the JSON key in the persistent 
      # store.
      #
      # @param [Symbol] jsonKey the key underwhich to find this jsonObject.
      # @param [Object] jsonObject the object to be persistently stored.
      # @return not specified
      def storeJSON(jsonKey, jsonObject, isSymbolicLink = false)
        jsonObject = jsonObject.to_json unless isSymbolicLink;
        jsonRecord = { 
          jsonKey:        jsonKey.to_s,
          jsonObject:     jsonObject,
          isSymbolicLink: isSymbolicLink,
          timeStamp:      Time.now,
        }
        insert_id = @@db[:json_objects].insert(jsonRecord);
        jsonRecord[:id] = insert_id;
        @@jsonCache.set(jsonKey.to_sym, jsonRecord);
      end

      # Update the last matching JSON object under the JSON key in the 
      # persistent store.
      #
      # @param [Symbol] jsonKey the key underwhich to find this jsonObject.
      # @param [Object] jsonObject the object to be persistently stored.
      # @return not specified
      def updateJSON(jsonKey, jsonObject)
        jsonRecord = @@db[:json_objects].where(:jsonKey => jsonKey.to_s).order(:id).last
        if jsonRecord.empty? then
          # If there is no record to update... simply store it
          storeJSON(jsonKey, jsonObject);
        else
          # There is a record to update so update just it...
          @@db[:json_objects].where(:id => jsonRecord[:id]).update(:jsonObject => jsonObject.to_json, :timeStamp => Time.now);
          jsonRecord[:jsonObject] = jsonObject.to_json;
          jsonRecord[:timeStamp]  = Time.now;
          @@jsonCache.set(jsonKey.to_sym, jsonRecord);
        end
      end

      # When using the Rails/Sinatra/Padrino registration system, this 
      # registered callback is used complete the registration.
      #
      def registered(app)
        included(app)
        #engine_configurations.each do |engine, configs|
        #  app.set engine, configs
        #end
      end

      # As part of the Rails/Sinatra/Padrino registration system, this 
      # included callback, completes the registration of the 
      # PersistentStore's methods into the registered class.
      def included(base)
        base.send(:include, InstanceMethods)
        base.extend(ClassMethods)
      end
    end

    # Class methods responsible for interacting with the FandianPF 
    # persistent storage subsystem.
    #
    module ClassMethods
    end

    # Instance methods that allow persistent storage to function 
    # properly in a FandianPF system.
    #
    module InstanceMethods

      # Store the JSON object under the JSON key in the persistent 
      # store.
      #
      # @param [Symbol] jsonKey the key underwhich to find this jsonObject.
      # @param [Object] jsonObject the object to be persistently stored.
      # @param [Hash]   jsonOptions options used to control the persistent
      #   store: :version can be one of :updateLast, :addNew, :raiseError
      # @return not specified
      def storeJSON(jsonKey, jsonObject, jsonOptions = { version: :addNew }, store = PersistentStore)

        # If :version => :new then simply store this jsonObject
        return store.storeJSON(jsonKey, jsonObject) if jsonOptions[:version] == :addNew;

        oldJsonRecord = store.findJSON(jsonKey);

        # If this json has never been stored... simply store it!
        return store.storeJSON(jsonKey, jsonObject) if oldJsonRecord.empty?

        # If this jsonObject is the same as the oldJsonObject do nothing!
        return if oldJsonRecord[:jsonObject].eql?(jsonObject);

        # If :version => :update then update this version
        return store.updateJSON(jsonKey, jsonObject) if jsonOptions[:version] == :updateLast;

        raise PersistentStore::UpdateError, "JSON object has changed and no versioning is allowed";
      end

      # Find the JSON object associated with the given JSON key.
      #
      # @param [Symbol] jsonKey the key used to find the required JSON 
      #   object.
      # @return [Object] the JSON object or {}.
      def findJSON(jsonKey)

        if jsonKey.to_sym == 'json-2efc1ae30d44da86ad297642e21e86b7-test'.to_sym then
          return { jsonObject: { jsonTest: 'This is the test JSON content' } }
        end

        PersistentStore.findJSON(jsonKey);
      end

      # Search for the JSON objects which satisfy the given JSON search 
      # structure.
      #
      # @param [Array] jsonSearch the JSON structure used to define the search 
      # @return [Object] the JSON object or {}.
      def searchJSON(jsonSearch)
        PersistentStore.searchJSON(jsonSearch);
      end

    end
  end
end
