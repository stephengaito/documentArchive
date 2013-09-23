###########################################################################
# The contents of this file should ONLY be altered by people who are 
# comfortable with the Ruby programming language and with how 
# Padrion/Sinatra/Rack/Puma work.
#
# Most configurational changes should be done using the YAML 
# settings.yml file.  See: config/settings.yml.example
############################################################################

##
# A MySQL connection:
# DataMapper.setup(:default, 'mysql://user:password@localhost/the_database_name')
#
# # A Postgres connection:
# DataMapper.setup(:default, 'postgres://user:password@localhost/the_database_name')
#
# # A Sqlite3 connection
# DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "development.db"))
#

DataMapper.logger = logger
DataMapper::Property::String.length(255)

require 'fandianpf/utils/database';
dataMapperURI = Fandianpf::Utils.getDataMapperURI(Padrino.env, Fandianpf::Utils::Options.getSettings);

logger.info "using database: #{dataMapperURI}";

DataMapper.setup(:default, dataMapperURI)

if Padrino.env == :development then
  DataMapper::Model.raise_on_save_failure = true  # globally across all models
end

##
# Add any database releated (RE)load hooks here
#
Padrino.after_load do
  DataMapper.finalize
  #
  # is a DataMapper.auto_upgrade! safe ?!?!?!?
  #
  DataMapper.auto_upgrade!
  Fandianpf::SecurityEvent.create(:description => "(re)Started FandianPF (#{Padrino.env})",
                                  :timeStamp => Time.now).save;
end


