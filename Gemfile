# The bundler Gemfile for the FandianPF project

# We can choose between two very different versions:
#
# MRI ruby:
#
#ruby '1.9.3', :engine => 'ruby', :engine_version => '1.9.3'
#
# and jRuby:
#
#ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.4'

source 'https://rubygems.org'

# Distribute your app as a gem
gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'
#
# We use the Puma webserver (which works in both ruby and jRuby).
gem 'puma'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'sass'
gem 'haml'
gem 'dm-sqlite-adapter'
gem 'dm-validations'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-types'
gem 'dm-core'

# Test requirements
group :test do
  #
  # We use rspec (and friends) for (internal) Test Driven Development.
  # 
  # We follow a "mockist" TDD pattern to specify the *behaviour* ... 
  # see:
  #   * Martin Fowler's [Mocks Aren't Stubs](http://martinfowler.com/articles/mocksArentStubs.html)
  # as well as:
  #   * [RSpec Mock's Further Reading](https://github.com/rspec/rspec-mocks#further-reading)
  #
  # For an overview of using RSpec/RSpec-mocks see:
  #   * [RSpec Core](https://github.com/rspec/rspec-core#rspec-core---)
  #   * [RSpec Expectations](https://github.com/rspec/rspec-expectations#rspec-expectations---)
  #   * [RSpec Mocks](https://github.com/rspec/rspec-mocks#rspec-mocks---)
  #
  # For a good but older comparison of Double frameworks see:
  #   * [Introducing RR](http://pivotallabs.com/introducing-rr/)
  #
  #  We have chosen RSpec Mocks over RR since we *want* the RSpec 
  #  "expectation" style as opposed to RR's terse syntax. We have 
  #  chosen RSpec Mocks over Mocha or Flexmock since on Ruby Toolbox, 
  #  RSpec Mocks looks like the most used/maintained Mocking project. 
  #  Further more, RSpec Mocks now has both double injection and 
  #  any_instance; see:
  #  [Delegating to the Original Implementation](https://github.com/rspec/rspec-mocks#delegating-to-the-original-implementation).
  #  and:
  #  [RSpec Mocks #any_instance](https://github.com/rspec/rspec-mocks/tree/master/lib/rspec/mocks/any_instance).
  #
  gem 'rspec'
  gem 'rspec-mocks'
  #
  # used to test the HTML/CSS/JavaScript/AJAX interfaces (we will need 
  # the Poltergist Capybara driver to test the JavaScript/AJAX 
  # interfaces).
  #
  gem 'capybara'
  # 
  # We use cucumber for (external/integration) Behavioural Driven 
  # Design
  #
  gem 'cucumber'
  #
  # We use cucumber/aruba to test external command line properties
  #
  gem 'aruba'
  #
  # Rack::Test is used by the capybara rack-test driver for testing 
  # HTML/CSS interfaces, as well as directly by our cucumber steps to 
  # test the RESTful interfaces
  #
  gem 'rack-test', :require => 'rack/test'
end

group :documentation do
  #
  # We use YARDoc documentation
  #
  gem 'yard-rspec'
  gem 'redcarpet'
end

# Padrino Stable Gem
gem 'padrino'
gem 'padrino-core'
#
# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'
#
# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.2'
# end
