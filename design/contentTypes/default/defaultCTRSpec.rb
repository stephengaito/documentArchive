require 'support/rspec_helper';

module Fandianpf; 

# The Fandianpf::ContentTypes module collects the specifications for 
# the various different content types used by the FandianPF system.
module ContentTypes

  # The Fandianpf::ContentTypes::Default module collects the 
  # specification for the default content type.
  module Default

    # Feature: provide default content type
    #
    feature Default do

      # The user, Wants to view the default content type

      # Scenario: show default content type
      #   When we get "/show/test"
      #   Then the result should contain default content class
      scenario "show default content type (as html)" do
        visit "/show/test";
        puts page.body;
        expect(page).to have_xpath("//div[@class='content']");
      end

      # The user, wants to get the default content type as json

      # Scenario: get content as json
      #   When we get "/show/test" as JSON
      #   Then the content-type should be 'application/json'
      scenario "get content as json" do
        getJson('show/test');
        expect(last_response.header['Content-type']).to match /application\/json/
      end

      # The user, Wants to add a new item of content using the default 
      # content type

      # Scenario: add new content
      #   When we post some json to "/show/test"
      #   Then
      #   When we visit "/show/test"
      #   Then the result should contain elements from the post
      scenario "add new content" do
        jsonContent = { someKey: "some thing" };
        putJson( '/show/test', jsonContent);
        visit "/show/test";
        puts page.body;
        expect(page).to have_xpath("//div[@field='someKey']");
      end
     
    end
  end
end; end
