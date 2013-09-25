# This is the spec_helper used for RSpec specifications which use the 
# Rack stack.

if not defined?(PADRINO_ENV) then
  # specifies to the system which type of environment is being run: 
  # development, test or production.
  #
  PADRINO_ENV = 'test' 
end

require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

RSpec.configure do |conf|
  conf.mock_with :rspec
  conf.include Rack::Test::Methods
end

# The following code, taken from Capybara/Cucumber, allows the use of 
# feature as a (super)alias of RSpec's describe.
#
def feature(*args, &block)
  options = if args.last.is_a?(Hash) then args.pop else {} end
  options[:capybara_feature] = true
  options[:type] = :feature
  options[:caller] ||= caller
  args.push(options)

  describe(*args, &block)
end

# The following code could be used instead of the Capybara/Cucumber 
# "feature" definition (above) to implement "feature" and "sceneario" 
# as aliases of "describe" and "it" respectively.
#
#module RSpec
#  module Core
#    module DSL
#      alias_method :feature, :describe
#    end
#    class ExampleGroup
#      class << self 
#        define_example_method :scenario
#      end
#    end
#  end
#end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Fandianpf::App
#   app Fandianpf::App.tap { |a| }
#   app(Fandianpf::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

Capybara.run_server = false;
Capybara.app = app;
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :browser => :chrome)
end

def getJson(url)
  get(url, 
      {}, 
      { 'HTTP_ACCEPT' => "application/json" });
end

def postJson(url, jsonContent)
  post(url, 
       jsonContent.to_json, 
       { 'Content-type' => 'application/json'});
end

def putJson(url, jsonContent)
  put(url, 
      jsonContent.to_json, 
      { 'Content-type' => 'application/json'});
end
