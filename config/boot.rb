# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

# The toSymbolHash function is used to ensure all the settings (Hash) 
# keys are symbols (see below).
#
def toSymbolHash(aHash)
  aHash.keys.each do | anOldKey |
    next if anOldKey.is_a?(Symbol);
    if anOldKey.is_a?(String) then
      anOldValue = aHash.delete(anOldKey);
      toSymbolHash(anOldValue) if anOldValue.is_a?(Hash);
      aHash[anOldKey.to_sym] = anOldValue;
    end
  end
end

# Deal with the command line options, load the configuration settings 
# YAML file and merge the options and create the padrionSettings to be 
# used by the config/apps.rb code later in the loading process.
#
# Start by ensuring that the command line options exist even if we are 
# not required by the bin/fandianpf code.
#
$cmdLineOptions    = Hash.new()  unless defined?($cmdLineOptions);
$cmdLineOptions[:host] = '127.0.0.1' unless $cmdLineOptions.has_key?(:host);
$cmdLineOptions[:port] = 3000        unless $cmdLineOptions.has_key?(:port);
$cmdLineOptionKeys = [ 
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
padrinoSettingsFile = $cmdLineOptions[:settings] if $cmdLineOptions.has_key?(:settings);
#
$padrinoSettings = Hash.new();
require 'yaml';
$padrinoSettings = YAML::load_file(padrinoSettingsFile) if File.readable?(padrinoSettingsFile);
toSymbolHash($padrinoSettings);
#
# Remove the command line options from the application settings
#
$padrinoOptions = Hash.new();
$cmdLineOptionKeys.each do | cmdLineKey |
  cmdLineKeyStr = cmdLineKey.to_s;
  if $padrinoSettings.has_key?(cmdLineKeyStr) then
    $padrinoOptions[cmdLineKey] = $padrinoSettings.delete(cmdLineKeyStr);
  end
end
#
# Merge the command line options into the padrino options comming from 
# the settings file.
#
$padrinoOptions.merge!($cmdLineOptions);

Dir.chdir($padrinoOptions[:chdir]) if $padrinoOptions.has_key?(:chdir);

Padrino.load!
