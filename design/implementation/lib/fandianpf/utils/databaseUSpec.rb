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

      it "::getSequelURI returns standard sqlite uri if no settings found" do
        Database.getSequelURI(:production,  {}, @fileUtilsClass, @fileClass).should  eql "sqlite://#{Dir.getwd}/db/fandianpf_production.sqlite";
        Database.getSequelURI(:test,        {}, @fileUtilsClass, @fileClass).should        eql "sqlite://#{Dir.getwd}/db/fandianpf_test.sqlite";
        Database.getSequelURI(:development, {}, @fileUtilsClass, @fileClass).should eql "sqlite://#{Dir.getwd}/db/fandianpf_development.sqlite";
      end

      it "::getSequelURI returns specified URI if specified in settings" do
        Database.getSequelURI(:test, { :sequelTestURI => 'testURI' }, @fileUtilsClass, @fileClass).should eql "testURI";
      end

      it "::getSequelURI does not alter sqlite path if it does not begin with '/./'" do
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_not_receive(:mkpath);
        Database.getSequelURI(:test, { :sequelTestURI => 'sqlite:///testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite:///testURI';
      end

      it "::getSequelURI pre-pends current working directory to sqlite path if the settings path starts with '/./'" do
        uri = Database.getSequelURI(:test, { :sequelTestURI => 'sqlite:///./testURI' }, @fileUtilsClass, @fileClass);
        uri.should eql "sqlite://#{Dir.getwd}/testURI";
      end

      it "::getSequelURI ensures all filesystem paths exist for SQLite databases" do
        @fileClass.stub(:directory?).and_return(false);
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_receive(:mkpath).with("/tmp");
        Database.getSequelURI(:test, { :sequelTestURI => 'sqlite:///tmp/testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite:///tmp/testURI';
      end
    end
  end
end; end; end
