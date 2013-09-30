require 'fandianpf/persistentStore';

module Fandianpf; module Spec;  

  # The Fandianpf::Spec::PersistentStore module collects the 
  # specifications for the Fandianpf::PersistentStore module.
  module PersistentStoreSpec
    include Fandianpf::PersistentStore;

    describe PersistentStore do

      before(:each) do
        @fileUtilsClass = double();
        @fileUtilsClass.stub(:mkpath);
        @fileClass = double();
        @fileClass.stub(:directory?).and_return(true);
      end

      it "::getSequelURI returns standard sqlite uri if no settings found" do
        PersistentStore.getSequelURI(:production,  {}, @fileUtilsClass, @fileClass).should  eql "sqlite://#{Dir.getwd}/db/fandianpf_production.sqlite";
        PersistentStore.getSequelURI(:test,        {}, @fileUtilsClass, @fileClass).should        eql "sqlite://#{Dir.getwd}/db/fandianpf_test.sqlite";
        PersistentStore.getSequelURI(:development, {}, @fileUtilsClass, @fileClass).should eql "sqlite://#{Dir.getwd}/db/fandianpf_development.sqlite";
      end

      it "::getSequelURI returns specified URI if specified in settings" do
        PersistentStore.getSequelURI(:test, { :sequelTestURI => 'testURI' }, @fileUtilsClass, @fileClass).should eql "testURI";
      end

      it "::getSequelURI does not alter sqlite path if it does not begin with '/./'" do
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_not_receive(:mkpath);
        PersistentStore.getSequelURI(:test, { :sequelTestURI => 'sqlite:///testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite:///testURI';
      end

      it "::getSequelURI pre-pends current working directory to sqlite path if the settings path starts with '/./'" do
        uri = PersistentStore.getSequelURI(:test, { :sequelTestURI => 'sqlite:///./testURI' }, @fileUtilsClass, @fileClass);
        uri.should eql "sqlite://#{Dir.getwd}/testURI";
      end

      it "::getSequelURI ensures all filesystem paths exist for SQLite databases" do
        @fileClass.stub(:directory?).and_return(false);
        @fileClass.should_receive(:directory?);
        @fileUtilsClass.should_receive(:mkpath).with("/tmp");
        PersistentStore.getSequelURI(:test, { :sequelTestURI => 'sqlite:///tmp/testURI' }, @fileUtilsClass, @fileClass).should eql 'sqlite:///tmp/testURI';
      end
    end
  end
end; end
