require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:datamapper)
PadrinoTasks.init

# Maintain the YARDoc documentation
task :yardocs do
  rubyFileNames = FileList['Rakefile', '**/Rakefile', 'app/**/*.rb', 'lib/**/*.rb', 'spec/**/*.rb'];
  sh "yardoc --plugin yard-rspec -o doc/html/fandianpf #{rubyFileNames}"
end
#
task :yardStats do
  rubyFileNames = FileList['Rakefile', '**/Rakefile', 'app/**/*.rb', 'lib/**/*.rb', 'spec/**/*.rb'];
  sh "yard stats --list-undoc #{rubyFileNames}"
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
# RSpect tests library function specifications
#
task :rtbt do
  sh "rspec --tag tbt"
end

