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
require 'fandianpf';

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

# Note that the Padrino::Logger configuration is different from the 
# standard Sinatra/Padrino 'set' based configuration. More over the 
# logger is configured to swallow all messages in the test environment 
# (which is unhelpful to say the least in a test first environment).  
# SO we configure the logger for the :test environment here.
#
Padrino::Logger::Config[:test][:log_level]  = :info
Padrino::Logger::Config[:test][:log_static] = true
Padrino::Logger::Config[:test][:stream]     = :to_file


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

# Load the configuration settings YAML file and merge the options and 
# create the padrionSettings to be used by the config/apps.rb code 
# later in the loading process.
#
require 'fandianpf/utils/options';

Fandianpf::Utils::Options.loadSettings();

Dir.chdir(Fandianpf::Utils::Options[:chdir]) if Fandianpf::Utils::Options.has_key?(:chdir);

Padrino.load!
