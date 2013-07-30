###########################################################################
# The contents of this file should ONLY be altered by people who are 
# comfortable with the Ruby programming language and with how 
# Padrion/Sinatra/Rack/Puma work.
#
# Most configurational changes should be done using the YAML 
# settings.yml file.  See: config/settings.yml.example
############################################################################

# Defines our constants

# The PADRINO_ENV constant is a global constant which is used to 
# determine which type of FandianPF (Padrino) webserver { 'production', 
# 'test', 'development' } is being created.
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)

# The PADRINO_ROOT constant is a global constant which specifies the 
# root directory of the FandianPF (Padrino) code base.
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

# Deal with the command line options, load the configuration settings 
# YAML file and merge the options and create the padrionSettings to be 
# used by the config/apps.rb code later in the loading process.
#
require 'fandianpf/utils/settings';

# Some entry points to config/boot.rb do not initialize $cmdLineOptions
# so as a fall back do it here.
#
$cmdLineOptions = Hash.new() unless defined?($cmdLineOptions);
$padrinoOptions, $padrinoSettings = Fandianpf::Utils.managePadrinoOptionsAndSettings($cmdLineOptions);

Dir.chdir($padrinoOptions[:chdir]) if $padrinoOptions.has_key?(:chdir);

Padrino.load!
