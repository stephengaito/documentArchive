require 'support/rspec_helper';

setRSpecLogging false;

module Fandianpf; module ContentTypes

  # The Fandianpf::ContentTypes::Author module collects the 
  # specification for the author content type.
  module Author

    # Feature: provide author content type
    #
    feature Author do

      before(:each) do
        @jsonAuthorContent = {
          :surname=>"Surname",
          :von=>"von",
          :firstname=>"Firstname",
          :email=>"email@address",
          :institute=>"The author's institute",
          :cleanname=>"Firstname von Surname jr",
          :jr=>"jr",
          :notes=> "A note about the author",
          :synonym_of=>[],
          :url=>["firstURL", "secondURL"]
        }
      end

      # The user, Wants to add a new author

      scenario "add a new author (as JSON)" do
        PersistentStore.db.transaction(:rollback => :always) do
          putJson( '/add/FirstnameVonSurnameJR', @jsonAuthorContent);
          puts "lastResponse: [#{last_response.body}]" if rSpecLogging;
          visit "/show/FirstnameVonSurnameJR";
          puts page.body if rSpecLogging;
          expect(page).to have_xpath("//div[@db_id='1']");
          expect(page).to have_xpath("//div[@field='surname']");
        end # ROLLBACK
      end

    end
  end
end; end
