###########################################################################
# The contents of this file should ONLY be altered by people who are 
# comfortable with the Ruby programming language and with how 
# Padrino/Sinatra/Rack/Puma work.
#
# Most configurational changes should be done using the YAML 
# settings.yml file.  See: config/settings.yml.example
############################################################################

require 'fandianpf/persistentStore';
Fandianpf::PersistentStore.setup

##
# Add any database releated (RE)load hooks here
#
Padrino.after_load do
  Fandianpf::SecurityEvent.create(:description => "(re)Started FandianPF (#{Padrino.env})",
                                  :timeStamp => Time.now);

  # Do the required housekeeping if the webServerForks.
  Fandianpf::PersistentStore.webServerForks!;
end


