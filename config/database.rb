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

# configure database
#
# IF there are no database configuration directives set
# THEN we 
#  use Sqlite databases 
#  located in the db directory 
#  named fandianpf_<<Padrino.env>>.sqlite
#
# IF we are using sqlite and there is not pre-existing database, we 
# create one.  It is currently unknown if the sqlite3 adaptor will 
# create a new database if one does not already exist... if so we use 
# this behaviour... if not then we need to system("sqlite 
# #{sqliteDbFile}");
#
dataMapperURI  = "sqlite3:///./db/fandianpf_#{Padrino.env}.sqlite";
settingsKey = ('dataMapper'+Padrino.env.to_s.capitalize+'URI').to_sym;
dataMapperURI  = $padrinoSettings[settingsKey] if $padrinoSettings.has_key?(settingsKey);

if dataMapperURI.downcase =~ /^sqlite/ then
  sqliteDbURI = Addressable::URI.parse(dataMapperURI);
  sqliteDbPath     = sqliteDbURI.path;
  if sqliteDbPath =~ /^\/\.\// then
    sqliteDbURI.path = Dir.getwd + '/' + sqliteDbPath.sub(/^\/\.\//,'');
    FileUtils.mkpath(File.dirname(sqliteDbURI.path)) unless File.directory?(File.dirname(sqliteDbURI.path));
    dataMapperURI = sqliteDbURI.to_s;
  end
end

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


