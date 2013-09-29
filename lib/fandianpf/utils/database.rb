# This is a self contained library of utilities for use with managing 
# the initial setup of the FandianPF Sequel library.

require "addressable/uri"

module Fandianpf; module Utils

  # The Fandianpf::Utils::Database module collects the methods used to 
  # manage FandianPF's use of persistent storage.
  module Database

    # Get the Sequel URI so we can configure database
    #
    # IF there are no database configuration directives set
    # THEN we 
    #  use Sqlite databases 
    #  located in the db directory 
    #  named fandianpf_<<Padrino.env>>.sqlite
    #
    # @note SIDE-EFFECT: IF we are using sqlite we also ensure that the full path to the database file exists.
    #
    # @param [Symbol] padrinoEnv The current value of Padrino.env
    # @param [Hash]   padrinoSettings The current value of the global $padrinoSettings
    # @return [String]
    #
    def self.getSequelURI(padrinoEnv, padrinoSettings = {}, fileUtilsClass = FileUtils, fileClass = File )
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

  end
end; end

