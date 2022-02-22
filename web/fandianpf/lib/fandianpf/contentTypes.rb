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
        @@type2table.has_key?(aPossibleContentType);
      end

      # getContentTypes returns an array of the currently known content 
      # types.
      #
      # @return [Array of Symbols] the currently known content types
      def getContentTypes
        @@type2table.keys.sort
      end

      # getFields returns the fields associated with this content type.
      #
      # @param [Symbol] ctKlassName the name of the content type
      # @return [Array] the array of field names (possibly empty)
      def getFields4class(ctKlassName)
        return [] unless @@type2fields.has_key?(ctKlassName);
        @@type2fields[ctKlassName];
      end

      # isField checks the registry of content type fields to see if 
      # this is a known field.
      #
      # @param [String] aPossibleField the name of the field to check. 
      # @return Boolean whether or not the name is a recognized field.
      def isField(aPossibleField)
        @@field2tables.has_key?(aPossibleField);
      end

      # getContentFields returns an array of the currently known fields 
      # in all content types.
      #
      # @return [Array of Symbols] the currently known content fields
      def getContentFields
        @@field2tables.keys.sort
      end

      # getContentTypes returns the content types associated with this field.
      #
      # @param [Symbol] fieldName the name of the field
      # @return [Array] the array of content types (possibly empty)
      def getTables4field(fieldName)
        return [] unless @@field2tables.has_key?(fieldName);
        @@field2tables[fieldName];
      end

      # registerContentType registers a new content type. It does this 
      # by requiring all **/*.rb files in the content type's directory, 
      # by copying all view templates from the views subdirectory to a 
      # subdirectory of the application's views directory whose name is 
      # the name of the contentType, and by recording the fields 
      # managed by this content type into the fields listing.
      #
      # @param [String] contentType the name of the content type 
      # @return not specified
      def registerContentType(contentType,
                              kernelKlass = Kernel,
                              fileKlass = File,
                              fileUtilsKlass = FileUtils,
                              fandianpfKlass = Fandianpf)

        # build all of the required klass names and paths
        contentType   = contentType.to_s;
        ctKlassName   = contentType.camelize;
        ctSnakeName   = contentType.underscore;
        ctBasePath    = "contentTypes/"+ctSnakeName;
        ctViewsPath   = ctBasePath+"/views";
        appViewsPath  = "app/views/"+ctSnakeName;
        ctRequirePath = ctBasePath+"/"+ctSnakeName;

        # install the views into the application's views directory
        fileUtilsKlass.cp_r(ctViewsPath, appViewsPath) if fileKlass.directory?(ctViewsPath);

        # load the content type class
        $LOAD_PATH.unshift(ctBasePath);
        kernelKlass.require(ctSnakeName);
        ctKlass = fandianpfKlass.const_get(ctKlassName);

        # now call the install method on the content type class
        ctKlass.install
        
        ctKlass.listMigrations

        ctKlass.doMigrations
      end

      # clear (setup) the ContentTypes class.
      def clear
        @@type2table       = Hash.new
        @@type2fields      = Hash.new
        @@type2description = Hash.new
        @@field2tables     = Hash.new
        @@field2types      = Hash.new
      end

      # ::registerFields registers both the database name and the JSON 
      # object fields which this database indexes.
      #
      # @param [Symbol] ctKlassName the name of the subclass 
      #   registering these fields.
      # @param [Symbol] tableName the name of this table in the 
      #   persistent store 
      # @param [Array of Symbols] fieldNames the names of the fields in 
      #   this table.
      # @return not specified
      def registerFields(ctKlassName, tableName, fieldNames)
        @@type2table[ctKlassName] = tableName;
        @@type2fields[ctKlassName] = fieldNames;
        fieldNames.each do | aFieldName |
          @@field2tables[aFieldName] = Array.new unless @@field2tables.has_key?(aFieldName);
          @@field2tables[aFieldName].push(tableName);
          @@field2types[aFieldName]  = Array.new unless @@field2types.has_key?(aFieldName);
          @@field2types[aFieldName].push(ctKlassName);
        end
      end

      # ::registerDescription registers a description for this content 
      # type suitable for showing to the user.
      #
      # @param [Symbol] ctKlassName the name of the subclass 
      #   registering this description.
      # @param [String] description the description for this content type
      # @return not specified
      def registerDescription(ctKlassName, description)
        @@type2description[ctKlassName] = description
      end

      # getContentTypeDescription returns a structured description of a 
      # given content type including the fields it knows about.
      #
      # @param [Symbol] ctKlassName the name of the content type.
      # @return [Hash] the structured description of the content type.
      def getContentTypeDescription(ctKlassName)
        description = Hash.new;
        description[:description] = @@type2description[ctKlassName] if @@type2description.has_key?(ctKlassName);
        description[:table]       = @@type2table[ctKlassName]       if @@type2table.has_key?(ctKlassName);
        description[:fields]      = @@type2fields[ctKlassName]      if @@type2fields.has_key?(ctKlassName);
        description
      end

      # getContentFieldDescription returns a structured description of a 
      # given content field including the types the use it.
      #
      # @param [Symbol] fieldName the name of the content field.
      # @return [Hash] the structured description of the content type.
      def getContentFieldDescription(fieldName)
        description = Hash.new;
        description[:types] = @@field2types[fieldName] if @@field2types.has_key? fieldName;
        description
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

      # registerContentType registers a new content type. It does this 
      # by requiring all **/*.rb files in the content type's directory, 
      # by copying all view templates from the views subdirectory to a 
      # subdirectory of the application's views directory whose name is 
      # the name of the contentType, and by recording the fields 
      # managed by this content type into the fields listing.
      #
      # @param [Symbol] contentType the name of the content type 
      # @return not specified
      def registerContentType(contentType)
        ContentTypes.registerContentType(contentType);
      end

      # getContentTypes returns an array of the currently known content 
      # types.
      #
      # @return [Array of Symbols] the currently known content types
      def getContentTypes
        ContentTypes.getContentTypes
      end

      # getContentFields returns an array of the currently known fields 
      # in all content types.
      #
      # @return [Array of Symbols] the currently known content fields
      def getContentFields
        ContentTypes.getContentFields
      end

      # getContentTypeDescription returns a structured description of a 
      # given content type including the fields it knows about.
      #
      # @param [Symbol] ctKlassName the name of the content type.
      # @return [Hash] the structured description of the content type.
      def getContentTypeDescription(ctKlassName)
        ContentTypes.getContentTypeDescription(ctKlassName);
      end

      # getContentFieldDescription returns a structured description of a 
      # given content field including the types the use it.
      #
      # @param [Symbol] fieldName the name of the content field.
      # @return [Hash] the structured description of the content type.
      def getContentFieldDescription(fieldName)
        ContentTypes.getContentFieldDescription(fieldName);
      end

    end
  end

  ContentTypes.clear;

  # The Fandianpf::ContentType class provides the base class for all 
  # content types used in the FandianPF system.
  #
  class ContentType

    # ::install installs this content type.
    #
    def self.install
      raise NotImplementedError, "The ::install method must be implemented by the subclass";
    end

    # ::doMigrations performs any and all migrations which have not yet 
    # been applied to the persitent store.
    #
    def self.listMigrations
      raise NotImplementedError, "The ::doMigrations method must be implemented by the subclass";
    end

    # ::registerFields registers both the database name and the JSON 
    # object fields which this database indexes.
    #
    # @param [Symbol] tableName the name of this table in the 
    #   persistent store 
    # @param [Array of Symbols] fieldNames the names of the fields in 
    #   this table.
    # @return not specified
    def self.registerFields(tableName, fieldNames)
      ContentTypes.registerFields(self.classname, tableName, fieldNames);
    end

    # ::registerDescription registers a description for this content 
    # type suitable for showing to the user.
    #
    # @param [String] description the description for this content type
    # @return not specified
    def self.registerDescription(description)
      ContentTypes.registerDescription(self.classname, description);
    end

    # ::migration conditionally performs one migration on the persitent
    # store.
    #
    # @param [Integer] versionNumber the sequential version number of 
    #   this migration.
    # @param [Block] &block the block with implements the migration
    # @return not specified
    def self.migration(versionNumber = 0, &block)
      PersistentStore.migration(self.classname, versionNumber, &block);
    end

    # ::doMigrations performs all required migrations associated with 
    # this content type.
    #
    # @return not specified
    def self.doMigrations
      PersistentStore.doMigrationsFor(self.classname);
    end

  end

end
