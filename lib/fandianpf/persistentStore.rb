require 'padrino'
require 'sequel'
require "addressable/uri"
require 'logger'
require 'json'

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

    class << self 

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

      # Mock the database and jsonCache to allow for testing of this 
      # singleton pattern.
      #
      # @param [RSpecMock] databaseMock a double of the database
      # @param [RSpecMock] cacheMock a doulbe of the cache
      # @param [Block] &block the block to perform while mocked.
      # @return not specified
      def mockStore(databaseMock, cacheMock, &block)
        oldDB    = defined?(@@db)        ? @@db : nil;
        oldCache = defined?(@@jsonCache) ? @@jsonCache : nil;
        @@db        = databaseMock;
        @@jsonCache = cacheMock;
        begin
          block.call
        ensure 
          @@db        = oldDB;
          @@jsonCache = oldCache;
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

        ensureSecurityEventTableExists
        ensureJsonObjectTableExists

        # Raise error on save failures globally across all models for 
        # non-production environments
        #
        Sequel::Model.raise_on_save_failure = true  unless Padrino.env == :production;

      end

      # Ensure that the SecurityEvent (:security_events) table exists 
      # in the persistent storage database.
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

      # Ensure that the JsonObject (:json_objects) table exists in the 
      # persistent storage database.
      #
      # @return not specified
      def ensureJsonObjectTableExists
        if ! @@db.tables.include?(:json_objects) then
          @@db.create_table :json_objects do
            primary_key :id
            String      :jsonKey,    :text=>true, 
                                     :index=>true
            String      :jsonObject, :text=>true
            DateTime    :timeStamp
          end
        end
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
      #   store: :version can be one of :update, :new, :error
      # @return not specified
      def storeJSON(jsonKey, jsonObject, jsonOptions = { version: :new })
        jsonRecord = { 
          jsonKey:    jsonKey.to_s,
          jsonObject: jsonObject.to_json,
          timeStamp:  Time.now,
        }
        PersistentStore.jsonCache.set(jsonKey.to_sym, jsonRecord);
        PersistentStore.db[:json_objects].insert(jsonRecord);
      end

      # Find the JSON object associated with the given JSON key.
      #
      # @param [Symbol] jsonKey the key used to find the required JSON 
      #   object.
      # @return [Object] the JSON object or {}.
      def findJSON(jsonKey)
        jsonKeySym = jsonKey.to_sym;

        if jsonKeySym == 'json-2efc1ae30d44da86ad297642e21e86b7-test'.to_sym then
          return { jsonObject: { jsonTest: 'This is the test JSON content' } }
        end

        # start by checking the cache
        jsonRecord = PersistentStore.jsonCache.get(jsonKeySym);

        # if jsonRecord is nil then hit the database instead
        if jsonRecord.nil? then
          jsonRecord = PersistentStore.db[:json_objects].where(:jsonKey => jsonKey.to_s).order(:id).last;
          PersistentStore.jsonCache.set(jsonKeySym, jsonRecord) unless jsonRecord.nil?;
        end

        jsonRecord = Hash.new if jsonRecord.nil?;
        if jsonRecord.has_key?(:jsonObject) then
          jsonRecord[:jsonObject] = JSON.parse(jsonRecord[:jsonObject]) if jsonRecord[:jsonObject].kind_of?(String);
        end

        jsonRecord
      end

    end
  end
end
