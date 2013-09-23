###########################################################################
# The contents of this file should ONLY be altered by people who are 
# comfortable with the Ruby programming language and with how 
# Padrion/Sinatra/Rack/Puma work.
#
# Most configurational changes should be done using the YAML 
# settings.yml file.  See: config/settings.yml.example
############################################################################

##
# This file mounts each app in the Padrino project to a specified 
# sub-uri. You can mount additional applications using any of these 
# commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project 
# root at '/app_name'.
#
# Note 2: If you use the host matching remember to respect the order of 
# the rules.
#
# By default, this file mounts the primary app which was generated with 
# this project. However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', 
#                            :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '10a17c1b4628fcb0fcd1ec00f255162b3bf03a15b6e05eb750fb19c98869981b'
  set :protection, true
  set :protect_from_csrf, true
  #
  # add the global Padrino settings from the config/settings.yml file 
  # which was loaded by config/boot.rb.
  #
  set Fandianpf::Utils::Options.getSettings;
end

# Mounts the core application for this project
Padrino.mount('Fandianpf::App', 
              :app_file => Padrino.root('app/app.rb')).to('/')
