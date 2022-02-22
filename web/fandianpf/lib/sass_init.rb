
# The SassInitialize module provides an entry point for registering 
# Padrino::Applications with the Sass system.
module SassInitializer
  # The SassInitializer.registered method enables support for SASS 
  # template reloading in rack applications. See 
  # http://nex-3.com/posts/88-sass-supports-rack for more details. 
  # Store SASS files (by default) within 'app/stylesheets'
  #
  # @param [Padrino::Application] app the app to be registered
  # @return unknown
  def self.registered(app)
    require 'sass/plugin/rack'
    Sass::Plugin.options[:template_location] = Padrino.root("app/stylesheets")
    Sass::Plugin.options[:css_location] = Padrino.root("public/stylesheets")
    app.use Sass::Plugin::Rack
  end
end
