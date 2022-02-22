# This is a self contained library of utilities for use with managing 
# the FandianPF options and settings infrastructure.

require 'yaml';
require 'optparse';

module Fandianpf

  # The Fandianpf::Utils module collects the various utility type 
  # methods used by the FandianPF system.
  module Utils


    # The Fandianpf::Utils::Options class manages the **global** 
    # options required by the FandianPF system.
    #
    class Options

      # The toSymbolHash function is used to ensure all the settings 
      # (Hash) keys are symbols (see below).
      #
      # @param [Hash] aHash the Hash whose symbols will be changed (in place) from strings to symbols.
      # @return nothing
      def self.toSymbolHash(aHash)
        return unless aHash.is_a? Hash;
        aHash.keys.each do | anOldKey |
          next if anOldKey.is_a?(Symbol);
          if anOldKey.is_a?(String) then
            anOldValue = aHash.delete(anOldKey);
            toSymbolHash(anOldValue) if anOldValue.is_a?(Hash);
            aHash[anOldKey.to_sym] = anOldValue;
          end
        end
      end

      # The Options class method clear empties the current collection 
      # of options.
      #
      # @return none specified
      def self.clear
        @@options = Hash.new;
        @@cmdArgs = Array.new;
      end      

      # The Options class method []= allows the system to add a given 
      # option's value.
      #
      # @param [Symbol] key the key (as a symbol) representing the given option
      # @param [Object] value the value of the given option.
      # @return none specified
      #def self.[]= (key, value)
      #  @@options ||= Hash.new;
      #  @@options[key.to_sym] = value;
      #end

      # The Options class method [] returns the value associated with 
      # the given option key.
      #
      # @param [Symbol] key the key for the requesed option value
      # @return [Object] the value associated with the given option key
      def self.[] (key)
        @@options ||= Hash.new;
        @@options[key.to_sym];
      end

      # The Options.has_key? method checks to see if the Options class 
      # has the key (symbol) aKey.
      #
      # @param [Symbol] aKey the key to check for.
      # @return none specified
      def self.has_key?(aKey)
        @@options ||= Hash.new;
        @@options.has_key?(aKey.to_sym);
      end

      #
      # List the potential contents of the settings file which should be 
      # merged into the padrinoOptions
      #
      @@cmdLineOptionKeys = [ 
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


      # Set the array of command line arguments 
      #
      # @param [Array of Strings] cmdArgs the command line arguments
      # @return none specified
      def self.setCommandLineArguments(cmdArgs)
        @@cmdArgs = cmdArgs
      end

      # Parse the command line options.
      #
      # @param [Array] cmdArgs (optional) the command line arguments to parse.
      # @return none speficied
      def self.parseCommandLineArguments()
        #
        @@options ||= Hash.new;
        @@cmdArgs ||= ARGV;
        #
        # Start by ensuring that the command line options exist even if we are 
        # not required by the bin/fandianpf code.
        #
        @@options[:host] = '127.0.0.1' unless @@options.has_key?(:host);
        @@options[:port] = 3000        unless @@options.has_key?(:port);
        #
        # Now scan the command line for options
        #
        OptionParser.new do | opts |

          opts.banner = "Usage: fandianpf [options]";

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end

          opts.on("-e", "--environment TYPE", "Run Padrino in one of the following environment TYPEs {production, test, development}") do | opt |
            case opt 
            when /^[Pp]/ then
              @@options[:environment] = :production;
            when /^[Tt]/ then
              @@options[:environment] = :test;
            when /^[Dd]/ then
              @@options[:environment] = :development;
            end
            ENV['PADRINO_ENV'] = ENV['RACK_ENV'] = @@options[:environment].to_s;
          end

          opts.on("-c", "--chdir PATH", "Change directory to PATH before starting FandianPF") do | opt |
            @@options[:chdir] = opt;
          end

          opts.on("-s", "--settings PATH", "PATH to YAML server settings file") do | opt |
            @@options[:settings] = opt;
          end

          opts.on("-S", "--server SERVER", "Rack Handler (default autodetect)") do | opt |
            @@options[:server] = opt;
          end

          opts.on("-H", "--host HOST", "Bind to HOST address") do | opt |
            @@options[:host] = opt;
          end

          opts.on("-P", "--port PORT", "Use PORT") do | opt |
            @@options[:port] = opt.to_i;
          end

          opts.on("-D", "--[no]-daemonize", "Run as a daemonized process in the background") do | opt |
            @@options[:daemonize] = opt;
          end

          opts.on("-p", "--pid PID_FILE", "File in which to store the process PID") do | opt |
            @@options[:pid] = opt;
          end

          opts.on("-d", "--[no]-debug", "Set debugging flags") do | opt |
            @@options[:debug] = opt;
          end
        end.parse!(@@cmdArgs);
      end

      # The Options class method loadSettings method loads the 
      # configuration settings YAML file and merge them into the global 
      # options.
      #
      # @note All keys will be symbolized. 
      #
      # @note SIDE-EFFECTS this method will load the settings, if possible, from a YAML file located in the filesystem.  By default the settings file will be located in the config/settings.yml file.  The default path to the settings file can be over-ridden by the :settings command line option.
      #
      # @return none specified
      def self.loadSettings(yamlClass = YAML, fileClass = File)
        @@options ||= Hash.new;
        #
        # Now find and load the settings YAML file
        #
        settingsFile = "config/settings.yml";
        settingsFile = @@options[:settings] if @@options.has_key?(:settings);
        #
        settings = Hash.new();
        settings = yamlClass.load_file(settingsFile) if fileClass.readable?(settingsFile);
        toSymbolHash(settings);
        @@options.merge!(settings) do | key, oldValue, newValue |
          oldValue
        end
      end

      # The Options class getSettings method returns a hash of the 
      # current options keys *which are not* declared as command line 
      # options.
      #
      # @return [Hash] the current options which are not command line options
      def self.getSettings
        @@options ||= Hash.new;
        #
        # Remove the command line options from the application settings
        #
        settings = Hash.new();
        @@options.keys.each do | optionKey |
          next if @@cmdLineOptionKeys.include?(optionKey);
          settings[optionKey] = @@options[optionKey];
        end
        settings
      end

      # The Options class getOptions method returns all currently known 
      # options.
      #
      # @return [Hash] the current collection of options.
      def self.getOptions
        @@options ||= Hash.new;
        @@options;
      end

    end
  end
end

