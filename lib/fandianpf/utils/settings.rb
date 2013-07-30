# This is a self contained library of utilities for use with managing 
# the FandianPF settings infrastructure.

require 'yaml';

module Fandianpf

  # The Fandianpf::Utils module collects the various utility type 
  # methods used by the FandianPF system.
  module Utils

    # The toSymbolHash function is used to ensure all the settings (Hash) 
    # keys are symbols (see below).
    #
    # @param [Hash] aHash the Hash whose symbols will be changed (in place) from strings to symbols.
    # @return nothing
    def self.toSymbolHash(aHash)
      aHash.keys.each do | anOldKey |
        next if anOldKey.is_a?(Symbol);
        if anOldKey.is_a?(String) then
          anOldValue = aHash.delete(anOldKey);
          toSymbolHash(anOldValue) if anOldValue.is_a?(Hash);
          aHash[anOldKey.to_sym] = anOldValue;
        end
      end
    end

    # The managePadrinoOptionsAndSettings method will deal with the 
    # command line options, load the configuration settings YAML file 
    # and merge the options and create the padrionSettings to be used 
    # by the config/apps.rb code later in the loading process.
    #
    # @note All keys in both padrinoOptions and padrinoSettings will be symbolized. 
    #
    # @note SIDE-EFFECTS this method will load the settings, if possible, from a YAML file located in the filesystem.  By default the settings file will be located in the config/settings.yml file.  The default path to the settings file can be over-ridden by the :settings command line option.
    #
    # @param [Hash] cmdLineOptions the hash of command line options with symbolized keys.
    # @return [Array of Hash] an array containing the pardinoOptions followed by the padrinoSettings
    def self.managePadrinoOptionsAndSettings(cmdLineOptions = {}) 
      #
      # Start by ensuring that the command line options exist even if we are 
      # not required by the bin/fandianpf code.
      #
      cmdLineOptions[:host] = '127.0.0.1' unless cmdLineOptions.has_key?(:host);
      cmdLineOptions[:port] = 3000        unless cmdLineOptions.has_key?(:port);
      #
      # List the potential contents of the settings file which should be 
      # merged into the padrinoOptions
      #
      cmdLineOptionKeys = [ 
        :environment, # The type of Padrino environment to run {production, test, development}
        :chdir,       # Change directory to the specified path
        :server,      # Rack handler if this key is not set then will autodetect
        :host,        # numeric interface on which to bind http server
        :port,        # port at which to listen for http requests
        :daemonize,   # boolean flag to run server process in background
        :pid,         # path to the file to contain the server proces PID
        :debug,       # boolean flag to produce debug output if true
        :settings     # path to the settings file
      ];
      #
      # Now find and load the settings YAML file
      #
      padrinoSettingsFile = "config/settings.yml";
      padrinoSettingsFile = cmdLineOptions[:settings] if cmdLineOptions.has_key?(:settings);
      #
      padrinoSettings = Hash.new();
      padrinoSettings = YAML::load_file(padrinoSettingsFile) if File.readable?(padrinoSettingsFile);
      toSymbolHash(padrinoSettings);
      #
      # Remove the command line options from the application settings
      #
      padrinoOptions = Hash.new();
      cmdLineOptionKeys.each do | cmdLineKey |
        cmdLineKeyStr = cmdLineKey.to_s;
        if padrinoSettings.has_key?(cmdLineKeyStr) then
          padrinoOptions[cmdLineKey] = padrinoSettings.delete(cmdLineKeyStr);
        end
      end
      #
      # Merge the command line options into the padrino options comming from 
      # the settings file.
      #
      padrinoOptions.merge!(cmdLineOptions);
      return [ padrinoOptions, padrinoSettings ];
    end

  end
end

