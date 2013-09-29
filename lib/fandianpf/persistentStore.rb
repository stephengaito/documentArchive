require 'sequel'
require 'fandianpf/utils/database';

module Fandianpf

  # The FandianPF persistent storage subsystem.
  #
  module PersistentStore

    class << self 

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

        sequelURI = Fandianpf::Utils::Database.getSequelURI(Padrino.env, Fandianpf::Utils::Options.getSettings);

        logger.info "using database: #{sequelURI}";

        @@db = Sequel.connect(sequelURI, loggers: [ logger ] )

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
            String      :objectKey,  :text=>true
            String      :jsonObject, :text=>true
          end
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
    end
  end
end
