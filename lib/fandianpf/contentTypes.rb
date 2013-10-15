#require 'padrino'
#require 'sequel'
#require "addressable/uri"
#require 'logger'
require 'json'

module Fandianpf

  # The FandianPF content type subsystem provides, among other things, 
  # a registry of all know content types and their fields.
  #
  module ContentTypes

    class << self 

      # isContentType checks the registry of content types to see if 
      # this is a known content type.
      #
      # @param [String] aPossibleContentType the name of the content type to check. 
      # @return Boolean whether or not the name is a recognized content type.
      def isContentType(aPossibleContentType)
        true;
      end

      # isField checks the registry of content type fields to see if 
      # this is a known field.
      #
      # @param [String] aPossibleField the name of the field to check. 
      # @return Boolean whether or not the name is a recognized field.
      def isField(aPossibleField)
        true;
      end

      # When using the Rails/Sinatra/Padrino registration system, this 
      # registered callback is used complete the registration.
      #
      def registered(app)
        included(app)
        #engine_configurations.each do |engine, configs|
        #  app.set engine, configs
        #end
      end

      # As part of the Rails/Sinatra/Padrino registration system, this 
      # included callback, completes the registration of the 
      # PersistentStore's methods into the registered class.
      def included(base)
        base.send(:include, InstanceMethods)
        base.extend(ClassMethods)
      end
    end

    # Class methods responsible for interacting with the FandianPF 
    # persistent storage subsystem.
    #
    module ClassMethods
    end

    # Instance methods that allow persistent storage to function 
    # properly in a FandianPF system.
    #
    module InstanceMethods

      # isContentType checks the registry of content types to see if 
      # this is a known content type.
      #
      # @param [String] aPossibleContentType the name of the content type to check. 
      # @return Boolean whether or not the name is a recognized content type.
      def isContentType(aPossibleContentType, registry = ContentTypes)
        registry.isContentType(aPossibleContentType);
      end

      # isField checks the registry of content type fields to see if 
      # this is a known field.
      #
      # @param [String] aPossibleField the name of the field to check. 
      # @return Boolean whether or not the name is a recognized field.
      def isField(aPossibleField)
        ContentTypes.isField(aPossibleField);
      end

    end
  end
end
