require 'support/rspec_helper';

module Fandianpf; module Architecture

  # The Fandianpf::Architecture::Search module collects the 
  # specifications for the search architecture.
  module Search

    # Feature: provide simple (URL based) search capabilities
    #
    feature Search, 'simple' do

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

      # The user, Wants to search by surname
      #
      scenario "search by field surname" do
        PersistentStore.db.transaction(:rollback => :always) do
          putJson( '/add/FirstnameVonSurnameJR', @jsonAuthorContent);
          puts "lastResponse: [#{last_response.body}]"
          visit "/search/surname/Surname";
          puts page.body;
        end
      end

    end
  end
end; end

