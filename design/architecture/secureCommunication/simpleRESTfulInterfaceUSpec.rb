require 'support/spec_helper';

module Fandianpf; module Architecture; module SecureCommunication
  module SimpleRESTfulInterface

    # Feature: simple RESTful interface
    #
    feature SimpleRESTfulInterface do

      #   In order to up/down-load raw content
      #   The power-user 
      #   wants to up/down-load json content

      #   Scenario: download json content
      #     When we get json from '/testJson'
      #     Then testJson.json is downloaded
      #
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
end; end; end
