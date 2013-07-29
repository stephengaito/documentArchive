PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
require 'aruba/cucumber'
require 'rspec/expectations'

##
# You can handle all padrino applications using instead:
#   Padrino.application
Capybara.app = Fandianpf::App.tap { |app|  }

module Fandianpf
  module World
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
  end
end

World(Fandianpf::World, Rack::Test::Methods) 

# Additional cucumber/aruba standard steps

When(/^I kill all processes$/) do 
  terminate_processes!
end

When(/^I run fandianpf$/) do
  steps %Q{
    Given The default aruba timeout is 10 seconds
    And I run `fandianpf` interactively
    And I wait for stdout to contain "Listening on tcp"
    And I kill all processes
  }
end
