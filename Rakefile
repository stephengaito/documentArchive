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
task :ispecs do
  # TODO: startup application
  sh "rspec -fs --pattern design/**/*ISpec.rb"
  # TODO: tear down application
end
#
task 'ls:ispecs' do
  sh "find design -name \"*ISpec*\""
end
#
# Integration tests against possible unstable running application 
# instances.  Each RSpec specification (file) is responsible for 
# starting their copy of the application using Aruba.
#
task :aspecs do
  sh "rspec -fs --pattern design/**/*ASpec.rb"
end
#
task 'ls:aspecs' do
  sh "find design -name \"*ASpec*\""
end
#
# Unit tests against the application's implementational use of the Rack 
# stack
# 
task :rspecs do
  sh "rspec -fs --pattern design/**/*RSpec.rb"
end
#
task 'ls:rspecs' do
  sh "find design -name \"*RSpec*\""
end
#
# Unit tests against individual parts of the application implementation
# 
task :uspecs do
  sh "rspec -fs --pattern design/**/*USpec.rb"
end
#
task 'ls:uspecs' do
  sh "find design -name \"*USpec*\""
end
#
# All RSpec specification tests
#
task :specs => [ :uspecs, :rspecs, :aspecs, :ispecs ]
#
task 'ls:specs' => [ 'ls:uspecs', 'ls:rspecs', 'ls:aspecs', 'ls:ispecs' ]
