require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:datamapper)
PadrinoTasks.init

# Maintain the YARDoc documentation
fandianpfFileNames = FileList['Rakefile', '**/Rakefile', 'app/**/*.rb', 'config/**/*.rb', 'lib/**/*.rb', 'spec/**/*.rb'];
yardPlugins = "--plugin yard-rspec --plugin yard-sinatra --plugin yard-padrino"
task :yardocs do
  sh "yardoc #{yardPlugins} -o doc/html/fandianpf #{fandianpfFileNames}"
end
#
task :yardStats do
  sh "yard stats #{yardPlugins} --list-undoc #{fandianpfFileNames}"
end
task :htmlDocs => :yardocs;

# Helper tasks for Cucumber/RSpec testing
#
# Cucumber tests "customer" facing integration features
#
task :ctbt do
  sh "cucumber --tags @tbt"
end
#
task :features do
  sh "rspec -fs --pattern features/**/*Feature.rb"
end
#
# RSpect tests library function specifications
#
task :rtbt do
  sh "rspec --tag tbt"
end
#
task :specs do
  sh "rspec -fs --pattern spec/**/*Spec.rb"
end
