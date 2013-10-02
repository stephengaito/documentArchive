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

  module PersistenStoreInstanceMethodsSpec

    describe PersistentStore::InstanceMethods do
      include Fandianpf::PersistentStore;
      include Fandianpf::PersistentStore::InstanceMethods;

      before(:each) do
        @jsonKey = 'json-test';
        @jsonKeySym = @jsonKey.to_sym;
        @jsonObject = { jsonTest: 'This is the test JSON content' };
        @jsonRecord = { jsonObject: @jsonObject.to_json };
      end

      it "::storeJSON stores a json object into both cache and database" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:set);
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:insert);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          storeJSON(@jsonKeySym, @jsonObject);
        end
      end 

      it "::findJSON will get a json object from the cache if it exists" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(@jsonRecord);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = findJSON(@jsonKeySym);
          #
          # check to make sure the JSON object has been parsed into a 
          # Ruby object.
          #
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to have_key :jsonObject;
          expect(jsonRecord[:jsonObject]).to be_kind_of Hash
        end
      end

      it "::findJSON will get a json object from the database if it does not exist in the cache and place it into the cache" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(nil);
        cacheMock.stub(:set);
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return(@jsonRecord);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          findJSON(@jsonKeySym);
        end
      end

      it "::findJSON will return an empty hash if json object does not exist in either cache or database it will not be put in cache" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(nil);
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return(nil);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = findJSON(@jsonKeySym);
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to be_empty;
        end
      end

    end
  end
end; end
