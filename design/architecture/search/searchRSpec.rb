require 'support/rspec_helper';

setRSpecLogging false;

module Fandianpf; module Architecture

  # The Fandianpf::Architecture::Search module collects the 
  # specifications for the search architecture.
  module Search

    # Feature: provide simple (URL based) search capabilities
    #
    feature Search, 'simple' do

      before(:each) do

        # add a simple content type
        ContentTypes.clear;
        ContentTypes.registerFields(:AuthorType, :author_type, [ :surname ]);
        ContentTypes.registerDescription :AuthorType, <<END_DESCRIPTION 
Authors allow you to keep notes, as well as contact details about 
authors you are interested in.
END_DESCRIPTION

        # now create some simple content
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

      # The user, Wants to search by surname
      #
      scenario "search by field surname" do
        PersistentStore.db.transaction(:rollback => :always) do
          putJson( '/add/FirstnameVonSurnameJR', @jsonAuthorContent);
          puts "lastResponse: [#{last_response.body}]" if rSpecLogging;
          visit "/search/surname/Surname";
          puts page.body if rSpecLogging;
        end
      end

    end
  end
end; end

