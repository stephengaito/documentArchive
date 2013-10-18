require 'support/rspec_helper';

module Fandianpf; module Specs;

  # The Fandianpf::ContentTypes module collects the specifications for 
  # the various different content types used by the FandianPF system.
  module ContentTypesSpecs

    # Feature: provide default content type
    #
    feature Fandianpf::ContentTypes do

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

      context 'listing content types' do

        before(:each) do
          ContentTypes.clear;
          ContentTypes.registerFields(:AuthorType, :author_type, [ :surname ]);
          ContentTypes.registerDescription :AuthorType, <<END_DESCRIPTION 
Authors allow you to keep notes, as well as contact details about 
authors you are interested in.
END_DESCRIPTION
        end

        scenario "list the currently known content types as html" do
          visit "/contentTypes"
          puts page.body
          listItems = page.all(:xpath, "//div[@class='listItem']/a");
          expect(listItems.length).to eql 1
          expect(listItems.at(0).text).to eql "AuthorType"
        end
     
        scenario "list the currently known content types as json" do
          getJson('contentTypes');
          expect(last_response.header['Content-type']).to match /application\/json/
          jsonContent = lastResponseAsJsonObj
          pp jsonContent;
          expect(jsonContent).to be_kind_of(Array);
          expect(jsonContent.length).to eql 1;
          expect(jsonContent[0]).to eql "AuthorType";
        end

        scenario "show the description of a specific content type as html" do
          visit "/contentTypes/AuthorType"
          puts page.body
          expect(page).to have_xpath("//div[@class='description']")
          expect(page).to have_xpath("//div[@class='table']")
          expect(page).to have_xpath("//div[@class='fieldsList']")
          fieldsList = page.all(:xpath, "//div[@class='fieldsList']/div/a");
          expect(fieldsList.length).to eql 1
          expect(fieldsList[0].text).to eql "surname";
        end

        scenario "show the description of a specific content type as json" do
          getJson("contentTypes/AuthorType");
          expect(last_response.header['Content-type']).to match /application\/json/
          jsonContent = lastResponseAsJsonObj
          pp jsonContent;
          expect(jsonContent).to be_kind_of(Hash);
          expect(jsonContent).to have_key :description
          expect(jsonContent[:description]).to match /authors/
          expect(jsonContent).to have_key :table
          expect(jsonContent[:table]).to eql "author_type";
          expect(jsonContent).to have_key :fields
          expect(jsonContent[:fields]).to be_kind_of Array;
          expect(jsonContent[:fields]).to include "surname"
        end

        scenario "list the currently known content fields as html" do
          visit "/contentFields"
          puts page.body
          listItems = page.all(:xpath, "//div[@class='listItem']/a");
          expect(listItems.length).to eql 1
          expect(listItems.at(0).text).to eql "surname"
        end
     
        scenario "list the currently known content fields as json" do
          getJson('contentFields');
          expect(last_response.header['Content-type']).to match /application\/json/
          jsonContent = lastResponseAsJsonObj
          pp jsonContent;
          expect(jsonContent).to be_kind_of(Array);
          expect(jsonContent.length).to eql 1;
          expect(jsonContent[0]).to eql "surname";
        end

        scenario "show the description of a specific content field as html" do
          visit "/contentFields/surname"
          puts page.body
#          expect(page).to have_xpath("//div[@class='description']")
#          expect(page).to have_xpath("//div[@class='table']")
          expect(page).to have_xpath("//div[@class='typesList']")
          typesList = page.all(:xpath, "//div[@class='typesList']/div/a");
          expect(typesList.length).to eql 1
          expect(typesList[0].text).to eql "AuthorType";
        end

        scenario "show the description of a specific content field as json" do
          getJson("contentFields/surname");
          expect(last_response.header['Content-type']).to match /application\/json/
          jsonContent = lastResponseAsJsonObj
          pp jsonContent;
          expect(jsonContent).to be_kind_of(Hash);
#          expect(jsonContent).to have_key :description
#          expect(jsonContent[:description]).to match /authors/
#          expect(jsonContent).to have_key :table
#          expect(jsonContent[:table]).to eql "author_type";
          expect(jsonContent).to have_key :types
          expect(jsonContent[:types]).to be_kind_of Array;
          expect(jsonContent[:types]).to include "AuthorType"
        end



      end

    end
  end
end; end
