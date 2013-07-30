# This is a self contained library of utilities for use with managing 
# the initial setup of the FandianPF DataMapper library.

require "addressable/uri"

module Fandianpf

  module Utils

    # Get the DataMapper URI so we can configure database
    #
    # IF there are no database configuration directives set
    # THEN we 
    #  use Sqlite databases 
    #  located in the db directory 
    #  named fandianpf_<<Padrino.env>>.sqlite
    #
    # SIDE-EFFECT: IF we are using sqlite we also ensure that the full path 
    # to the database file exists.
    #
    # @param [Symbol] padrinoEnv The current value of Padrino.env
    # @param [Hash]   padrinoSettings The current value of the global $padrinoSettings
    # @return [String]
    #
    def self.getDataMapperURI(padrinoEnv, padrinoSettings = {} )
      dataMapperURI  = "sqlite3:///./db/fandianpf_#{padrinoEnv}.sqlite";
      settingsKey = ('dataMapper'+padrinoEnv.to_s.capitalize+'URI').to_sym;
      dataMapperURI  = padrinoSettings[settingsKey] if padrinoSettings.has_key?(settingsKey);

      if dataMapperURI.downcase =~ /^sqlite/ then
        sqliteDbURI = Addressable::URI.parse(dataMapperURI);
        sqliteDbPath = sqliteDbURI.path;
        if sqliteDbPath =~ /^\/\.\// then
          sqliteDbURI.path = Dir.getwd + '/' + sqliteDbPath.sub(/^\/\.\//,'');
          dataMapperURI = sqliteDbURI.to_s;
        end
        FileUtils.mkpath(File.dirname(sqliteDbURI.path)) unless File.directory?(File.dirname(sqliteDbURI.path));
      end
      return dataMapperURI;
    end

  end
end

