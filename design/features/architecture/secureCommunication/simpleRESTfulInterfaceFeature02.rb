
require 'capybara/rspec'

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

module Fandianpf; module Feature
  module SimpleRESTfulInterface

    describe SimpleRESTfulInterface, :type => :feature do

    # In order to up/down-load raw content
    # The power-user 
    # wants to up/down-load json content

      scenario "download json content" do
        get('/testJson', {}, { 'HTTP_ACCEPT' => "application/json" });
        expect(last_response.header['Content-type']).to match /application\/json/
      end

#  Scenario: upload json content
#    When we post test2Json.json to '/test2Json' with body
#      """
#      { 
#        'test1': 'test1value',
#        'test2': [ 'test2valu0', 'test2value1' ]
#      }
#      """
#     And we get json from '/test2Json'
#    Then test2Json.json is downloaded

    end
  end
end; end
