require 'support/rspec_helper';

module Fandianpf; module Architecture

# The Fandianpf::Architecture::DuckTypes module collects the 
# specifications for the flexible use of "duck typed" content (AKA 
# plugins and friends).
module DuckTypes

  # The Fandianpf::Architecture::DuckTypes::DefaultModule module 
  # collects the specification for the default content type.
  module DefaultModule

    # Feature: provide default behaviour module
    #
    feature DefaultModule, :type => :feature do

      # In order to display content
      # The administrator
      # Wants to provide a defaul module

      # Scenario: load and use default module
      #   When we get "/show/test"
      #   Then the result should contain default content class
      scenario "load and use default module" do
        visit "/show/test";
        puts page.body;
        expect(page).to have_xpath("//div[@class='content']");
      end

    end
  end
end; end; end
