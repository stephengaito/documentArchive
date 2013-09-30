require 'sequel'
require "addressable/uri"
require 'logger'

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

        logger.level = Logger::INFO
        logger.info "using database: #{sequelURI}";
        puts "SETTING UP SEQUEL sqlite database #{sequelURI}"

        @@db = Sequel.connect(sequelURI, logger: logger )

        ensureSecurityEventTableExists
        ensureJsonObjectTableExists

        if Padrino.env == :development then
          Sequel::Model.raise_on_save_failure = true  # globally across all models
        end
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
            String      :jsonKey,   {:text=>true, 
                                     :unique=> true, 
                                     :index=>{:unique=>true}}
            String      :jsonObject, :text=>true
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
      # @return not specified
      def storeJSON(jsonKey, jsonObject)
        PersistentStore.db[:json_objects].insert({ jsonKey: jsonKey.to_s,
                            jsonObject: jsonObject.to_json });
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
        jsonRecord = PersistentStore.db[:json_objects].where(:jsonKey => jsonKey.to_s).order(:id).last
        jsonRecord[:jsonObject] = JSON.parse jsonRecord[:jsonObject];
        jsonRecord
      end

    end
  end
end
