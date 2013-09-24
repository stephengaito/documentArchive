require 'support/rspec_helper';

module Fandianpf; module Architecture; module DuckTypes

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
        expect(page).to have_xpath("//a[@class='content']");
      end

# Then(/^the result should contain default content class$/) do
#   puts last_response.body;
#   expect(last_response).to have_xpath("//a[@class='content']");
# end
    end
  end
end; end; end
