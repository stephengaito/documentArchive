require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

# Maintain the YARDoc documentation
fandianpfFileNames = FileList['Rakefile', '**/Rakefile', 'app/**/*.rb', 'lib/**/*.rb', 'design/**/*.rb'];
yardPlugins = "--plugin yard-rspec --plugin yard-sinatra --plugin yard-padrino"
task :yardocs do
  sh "yardoc #{yardPlugins} -o doc/html/fandianpf #{fandianpfFileNames}"
end
#
task :yardStats do
  sh "yard stats #{yardPlugins} --list-undoc #{fandianpfFileNames}"
end
task :htmlDocs => :yardocs;

# Helper tasks for RSpec testing
#
# Integration tests against a stable running application instance
#
iSpecs = FileList.new('design/**/*ISpec.rb');
task :ispecs do
  # TODO: startup application
  sh "rspec -fs #{iSpecs}"
  # TODO: tear down application
end
#
task 'ls:ispecs' do
  puts iSpecs
end
#
# Integration tests against possible unstable running application 
# instances.  Each RSpec specification (file) is responsible for 
# starting their copy of the application using Aruba.
#
aSpecs = FileList.new('design/**/*ASpec.rb');
task :aspecs do
  sh "rspec -fs #{aSpecs}"
end
#
task 'ls:aspecs' do
  puts aSpecs
end
#
# Unit tests against the application's implementational use of the Rack 
# stack
# 
rSpecs = FileList.new('design/**/*RSpec.rb');
task :rspecs do
  sh "rspec -fs #{rSpecs}"
end
#
task 'ls:rspecs' do
  puts rSpecs
end
#
# Unit tests against individual parts of the application implementation
# 
uSpecs = FileList.new('design/**/*USpec.rb');
task :uspecs do
  sh "rspec -fs #{uSpecs}"
end
#
task 'ls:uspecs' do
  puts uSpecs
end
#
# All RSpec specification tests
#
task :specs => [ :uspecs, :rspecs, :aspecs, :ispecs ]
#
task 'ls:specs' => [ 'ls:uspecs', 'ls:rspecs', 'ls:aspecs', 'ls:ispecs' ]
