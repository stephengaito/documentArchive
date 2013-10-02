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

      scenario "show default content type (as html)" do
        visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-test";
        puts page.body;
        expect(page).to have_xpath("//div[@field='jsonTest']");
      end

      # The user, wants to get the default content type as json

      scenario "get content as json" do
        getJson('show/json-2efc1ae30d44da86ad297642e21e86b7-test');
        expect(last_response.header['Content-type']).to match /application\/json/
        jsonContent = lastResponseAsJsonObj
        puts jsonContent;
        expect(jsonContent).to be_kind_of(Hash);
        expect(jsonContent[:jsonTest]).to match /This is the test JSON content/;
      end

      # The user, Wants to add a new item of content using the default 
      # content type

      scenario "add new content" do
        PersistentStore.db.transaction(:rollback => :always) do
          jsonContent = { someKey: "some thing" };
          putJson( '/add/json-2efc1ae30d44da86ad297642e21e86b7-puts-test', jsonContent);
          puts "lastResponse: [#{last_response.body}]"
          visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-puts-test";
          puts page.body;
          expect(page).to have_xpath("//div[@db_id='1']");
          expect(page).to have_xpath("//div[@field='someKey']");
        end # ROLLBACK
      end

      scenario "add new content twice" do
        PersistentStore.db.transaction(:rollback => :always) do
          jsonContent1 = { firstKey: "some thing" };
          jsonContent2 = { secondKey: "another thing" };
          putJson( '/add/json-2efc1ae30d44da86ad297642e21e86b7-puts-test', jsonContent1);
          puts "lastResponse: [#{last_response.body}]"
          visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-puts-test";
          puts page.body;
          expect(page).to have_xpath("//div[@field='firstKey']");
          expect(page).to have_xpath("//div[@db_id='1']");
          putJson( '/add/json-2efc1ae30d44da86ad297642e21e86b7-puts-test', jsonContent2);
          puts "lastResponse: [#{last_response.body}]"
          visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-puts-test";
          puts page.body;
          expect(page).to have_xpath("//div[@field='secondKey']");
          expect(page).to have_xpath("//div[@db_id='2']");
        end # ROLLBACK
      end
     
      scenario "add new content and then update it" do
        PersistentStore.db.transaction(:rollback => :always) do
          jsonContent1 = { firstKey: "some thing" };
          jsonContent2 = { secondKey: "another thing" };
          putJson( '/add/json-2efc1ae30d44da86ad297642e21e86b7-puts-test', jsonContent1);
          puts "lastResponse: [#{last_response.body}]"
          visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-puts-test";
          puts page.body;
          expect(page).to have_xpath("//div[@field='firstKey']");
          expect(page).to have_xpath("//div[@db_id='1']");
          putJson( '/update/json-2efc1ae30d44da86ad297642e21e86b7-puts-test', jsonContent2);
          puts "lastResponse: [#{last_response.body}]"
          visit "/show/json-2efc1ae30d44da86ad297642e21e86b7-puts-test";
          puts page.body;
          expect(page).to have_xpath("//div[@field='secondKey']");
          expect(page).to have_xpath("//div[@db_id='1']");
        end # ROLLBACK
      end
     
    end
  end
end; end
