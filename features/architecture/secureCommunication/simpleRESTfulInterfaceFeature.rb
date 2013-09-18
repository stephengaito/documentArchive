
require 'capybara/rspec'
require 'rack/test';
include Rack::Test::Methods

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
