require 'fandianpf/utils/database';

module Fandianpf; module Spec;  module Utils

  # The Fandianpf::Spec::Utils::Database module collects the 
  # specifications for the Fandianpf::Utils::Database module.
  module DatabaseSpec
    include Fandianpf::Utils;

    describe Database do

      before(:each) do
        @fileUtilsClass = double();
        @fileUtilsClass.stub(:mkpath);
        @fileClass = double();
        @fileClass.stub(:directory?).and_return(true);
      end

      it "::getDataMapperURI returns standard sqlite uri if no settings found" do
        Database.getDataMapperURI(:production,  {}, @fileUtilsClass, @fileClass).should  eql "sqlite3://#{Dir.getwd}/db/fandianpf_production.sqlite";
        Database.getDataMapperURI(:test,        {}, @fileUtilsClass, @fileClass).should        eql "sqlite3://#{Dir.getwd}/db/fandianpf_test.sqlite";
        Database.getDataMapperURI(:development, {}, @fileUtilsClass, @fileClass).should eql "sqlite3://#{Dir.getwd}/db/fandianpf_development.sqlite";
      end

      it "::getDataMapperURI returns specified URI if specified in settings" do
        Database.getDataMapperURI(:test, { :dataMapperTestURI => 'testURI' }, @fileUtilsClass, @fileClass).should eql "testURI";
      end

      it "::getDataMapperURI does not alter sqlite path if it does not begin with '/./'" do
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_not_receive(:mkpath);
        Database.getDataMapperURI(:test, { :dataMapperTestURI => 'sqlite3:///testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite3:///testURI';
      end

      it "::getDataMapperURI pre-pends current working directory to sqlite path if the settings path starts with '/./'" do
        uri = Database.getDataMapperURI(:test, { :dataMapperTestURI => 'sqlite3:///./testURI' }, @fileUtilsClass, @fileClass);
        uri.should eql "sqlite3://#{Dir.getwd}/testURI";
      end

      it "::getDataMapperURI ensures all filesystem paths exist for SQLite databases" do
        @fileClass.stub(:directory?).and_return(false);
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_receive(:mkpath).with("/tmp");
        Database.getDataMapperURI(:test, { :dataMapperTestURI => 'sqlite3:///tmp/testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite3:///tmp/testURI';
      end
    end
  end
end; end; end
