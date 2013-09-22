
require 'capybara/rspec'
require 'rack/test';
include Rack::Test::Methods

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

def feature(*args, &block)
  options = if args.last.is_a?(Hash) then args.pop else {} end
  options[:capybara_feature] = true
  options[:type] = :feature
  options[:caller] ||= caller
  args.push(options)

  describe(*args, &block)
end

module Fandianpf; module Feature
  module SimpleRESTfulInterface

    feature SimpleRESTfulInterface do

# Feature: simple RESTful interface

#   In order to up/down-load raw content
#   The power-user 
#   wants to up/down-load json content

#   Scenario: download json content
#     When we get json from '/testJson'
#     Then testJson.json is downloaded

      scenario "download json content" do
        get('/testJson', {}, { 'HTTP_ACCEPT' => "application/json" });
        expect(last_response.header['Content-type']).to match /application\/json/
      end

#   Scenario: upload json content
#     When we post test2Json.json to '/test2Json' with body
#       """
#       { 
#         'test1': 'test1value',
#         'test2': [ 'test2valu0', 'test2value1' ]
#       }
#       """
#      And we get json from '/test2Json'
#     Then test2Json.json is downloaded

    end
  end
end; end


# When(/^we get json from '\/testJson'$/) do
#   get('/testJson', {}, { 'HTTP_ACCEPT' => "application/json" });
# end

# Then(/^testJson\.json is downloaded$/) do
#   expect(last_response.header['Content-type']).to match /application\/json/
# end

