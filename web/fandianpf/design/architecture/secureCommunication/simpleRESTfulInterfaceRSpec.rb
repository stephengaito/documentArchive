require 'support/rspec_helper';

setRSpecLogging false

module Fandianpf; module Architecture

# The Fandianpf::Architecture::SecureCommunitcation module collects the 
# specifications for the use of secure inter-communication between 
# external applications and/or other FandianPF systems.
module SecureCommunication

  # The 
  # Fandianpf::Architecture::SecureCommunication::SimpleRESTfulInterface 
  # collects the specifications for the REST interfaces for FandianPF 
  # system.
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
        getJson('/testJson');
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
