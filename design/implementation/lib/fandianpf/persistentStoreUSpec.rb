require 'support/uspec_helper';

require 'fandianpf/persistentStore';

module Fandianpf; module Spec;  

  # The Fandianpf::Spec::PersistentStore module collects the 
  # specifications for the Fandianpf::PersistentStore module.
  module PersistentStoreSpec

    describe PersistentStore do

      before(:each) do
        @fileUtilsClass = double();
        @fileUtilsClass.stub(:mkpath);
        @fileClass = double();
        @fileClass.stub(:directory?).and_return(true);
        @jsonKey = 'json-test';
        @jsonKeySym = @jsonKey.to_sym;
        @jsonObject = { jsonTest: 'This is the test JSON content' };
        @jsonRecord = { jsonObject: @jsonObject };
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

      it "::storeJSON stores a json object into both cache and database" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:set) do | jsonKey, jsonObject |
          expect(jsonObject).to have_key :id
          expect(jsonObject).to have_key :isSymbolicLink
          expect(jsonObject[:isSymbolicLink]).to be_false;
          expect(jsonObject).to have_key :jsonObject
          expect(jsonObject[:jsonObject]).to eql "{\"jsonTest\":\"This is the test JSON content\"}"
        end
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:insert);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          PersistentStore.storeJSON(@jsonKeySym, @jsonObject);
        end
      end 

      it "::storeJSON stores a symbolic link if isSymbolicLink is true" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:set) do | jsonKey, jsonObject |
          expect(jsonObject).to have_key :id
          expect(jsonObject).to have_key :isSymbolicLink
          expect(jsonObject[:isSymbolicLink]).to be_true;
          expect(jsonObject).to have_key :jsonObject;
          expect(jsonObject[:jsonObject]).to eql "a symbolic link"
        end
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:insert);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          PersistentStore.storeJSON(@jsonKeySym, "a symbolic link", true);
        end
      end

      it "::updateJSON updates an existing json object into both cache and database" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:set) do | jsonKey, jsonObject |
          expect(jsonObject).to have_key :id
        end
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return({ id: 1 });
        datasetMock.stub(:update);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          PersistentStore.updateJSON(@jsonKeySym, @jsonObject);
        end
      end 

      it "::updateJSON should store the new JSON object if no JSON record exists" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:set) do | jsonKey, jsonObject |
          expect(jsonObject).to have_key :id
        end
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return({});
        datasetMock.stub(:update);
        datasetMock.stub(:insert);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          PersistentStore.updateJSON(@jsonKeySym, @jsonObject);
        end
      end 

      it "::findJSON will get a json object from the cache if it exists" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(@jsonRecord);
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = PersistentStore.findJSON(@jsonKeySym);
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
          PersistentStore.findJSON(@jsonKeySym);
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
          jsonRecord = PersistentStore.findJSON(@jsonKeySym);
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to be_empty;
        end
      end

      it "::findJSON will follow a number of symbolic links in the database" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(nil);
        cacheMock.stub(:set).with(:"json-test", {:isSymbolicLink=>true, :jsonObject=>"first symbolic link"}).ordered;
        cacheMock.stub(:set).with(:"first symbolic link", {:isSymbolicLink=>true, :jsonObject=>"second symbolic link"}).ordered;
        cacheMock.stub(:set).with(:"second symbolic link", {:jsonObject=>{:jsonTest=>"This is the test JSON content"}}).ordered;
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return(
          { isSymbolicLink: true, jsonObject: "first symbolic link" },
          { isSymbolicLink: true, jsonObject: "second symbolic link" },
          @jsonRecord
        );
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = PersistentStore.findJSON(@jsonKeySym);
          #
          # check to make sure the JSON object has been parsed into a 
          # Ruby object.
          #
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to have_key :jsonObject;
          expect(jsonRecord[:jsonObject]).to be_kind_of Hash
        end
      end

      it "::findJSON will follow a number of symbolic links in the database and cache" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(
          nil,
          {:isSymbolicLink=>true, :jsonObject=>"second symbolic link"},
          nil
        );
        cacheMock.stub(:set).with(:"json-test", {:isSymbolicLink=>true, :jsonObject=>"first symbolic link"}).ordered;
        cacheMock.stub(:set).with(:"second symbolic link", {:jsonObject=>{:jsonTest=>"This is the test JSON content"}}).ordered;
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return(
          { isSymbolicLink: true, jsonObject: "first symbolic link" },
          @jsonRecord
        );
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = PersistentStore.findJSON(@jsonKeySym);
          #
          # check to make sure the JSON object has been parsed into a 
          # Ruby object.
          #
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to have_key :jsonObject;
          expect(jsonRecord[:jsonObject]).to be_kind_of Hash
        end
      end

      it "::findJSON will detect loops of symbolic links" do
        databaseMock = double();
        datasetMock  = double();
        cacheMock    = double();
        cacheMock.stub(:get).and_return(nil);
        cacheMock.stub(:set).with(:"json-test", {:isSymbolicLink=>true, :jsonObject=>"first symbolic link"}).ordered;
        cacheMock.stub(:set).with(:"first symbolic link", {:isSymbolicLink=>true, :jsonObject=>"second symbolic link"}).ordered;
        cacheMock.stub(:set).with(:"second symbolic link", {:isSymbolicLink=>true, :jsonObject=>"first symbolic link"}).ordered;
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).and_return(datasetMock);
        datasetMock.stub(:order).and_return(datasetMock);
        datasetMock.stub(:last).and_return(
          { isSymbolicLink: true, jsonObject: "first symbolic link" },
          { isSymbolicLink: true, jsonObject: "second symbolic link" },
          { isSymbolicLink: true, jsonObject: "first symbolic link" },
        );
        PersistentStore.mockStore(databaseMock, cacheMock) do
          jsonRecord = PersistentStore.findJSON(@jsonKeySym);
          expect(jsonRecord).to be_kind_of Hash;
          expect(jsonRecord).to be_empty;
        end
      end

      it "::migration registers one conditional migration of the tables in the persistent store associated with this content type" do
        PersistentStore.mockStore(double(), double()) do
          PersistentStore.migration(:AuthorType, 1) do 
            # nothing to do
          end
          PersistentStore.migration(:AuthorType, 2) do 
            # nothing to do
          end
          migrations = PersistentStore.migrations;
          expect(migrations).to be_kind_of Hash;
          expect(migrations).to have_key :AuthorType;
          expect(migrations[:AuthorType]).to be_kind_of Hash;
          expect(migrations[:AuthorType]).to have_key 1;
          expect(migrations[:AuthorType][1]).to be_kind_of Proc;
          expect(migrations[:AuthorType]).to have_key 2;
          expect(migrations[:AuthorType][2]).to be_kind_of Proc;
        end
      end

      it "::migration raises MigrationError if multiple migrations are registered for the same version number" do
        PersistentStore.mockStore(double(), double()) do
          PersistentStore.migration(:AuthorType, 1) do 
            # nothing to do
          end
          expect {
            PersistentStore.migration(:AuthorType, 1) do 
              # nothing to do
            end
          }.to raise_error(Fandianpf::PersistentStore::MigrationError);
        end
      end

      it "::getMigrationVersion gets the last migration version associated with this content type" do
        databaseMock = double();
        datasetMock  = double();
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).with({:contentTypeName=>'AuthorType'}).and_return(datasetMock);
        datasetMock.stub(:order).with(:id).and_return(datasetMock);
        datasetMock.stub(:last).and_return({ :contentTypeName=>'AuthorType', :migrationVersion=>1});
        PersistentStore.mockStore(databaseMock, double()) do
          expect(PersistentStore.getMigrationVersion(:AuthorType)).to eql 1;
        end
      end

      it "::getMigrationVersion sets the last migration version to -1 if no migration version has ever been associated with this content type" do
        databaseMock = double();
        datasetMock  = double();
        databaseMock.stub(:[]).and_return(datasetMock);
        datasetMock.stub(:where).with({:contentTypeName=>'AuthorType'}).and_return(datasetMock);
        datasetMock.stub(:order).with(:id).and_return(datasetMock);
        datasetMock.stub(:last).and_return(nil);
        datasetMock.stub(:insert).with({:contentTypeName=>'AuthorType', :migrationVersion=>-1}).and_return(-1);
        PersistentStore.mockStore(databaseMock, double()) do
          expect(PersistentStore.getMigrationVersion(:AuthorType)).to eql -1;
        end
      end

      it "::doMigrations performs all required migrations associated with a given content type" do
        databaseMock  = double();
        datasetMock   = double();
        sequelMock    = double();
        migrationMock = double();
        databaseMock.stub(:[]).and_return(datasetMock);
        databaseMock.stub(:transaction) do | &aBlock |
          aBlock.call
        end
        datasetMock.stub(:where).with({:contentTypeName=>'AuthorType'}).and_return(datasetMock);
        datasetMock.stub(:where).with({:id=>1}).and_return(datasetMock);
        datasetMock.stub(:order).with(:id).and_return(datasetMock);
        datasetMock.stub(:last).and_return({ :id=>1, :contentTypeName=>'AuthorType', :migrationVersion=>1});
        datasetMock.stub(:update).with({:migrationVersion=>2});
        sequelMock.stub(:migration) do | &aBlock |
          expect(&aBlock).to be_kind_of Proc
          expect { 
            aBlock.call
          }.to raise_error(Fandianpf::PersistentStore::MigrationError);
          migrationMock
        end
        migrationMock.stub(:apply).with(databaseMock, :up);
        PersistentStore.mockStore(databaseMock, double()) do
          PersistentStore.migration(:AuthorType, 1) do 
            raise Fandianpf::PersistentStore::UpdateError, "this block should NOT be called";
          end
          PersistentStore.migration(:AuthorType, 2) do 
            raise Fandianpf::PersistentStore::MigrationError, "this block SHOULD be called";
          end
          PersistentStore.doMigrations(:AuthorType, sequelMock) 
        end
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
        @jsonRecord = { jsonObject: @jsonObject };
      end

      it "::storeJSON with version:new simply stores the JSON object" do
        store = double();
        store.stub(:storeJSON);
        storeJSON(@jsonKey, @jsonObject, { version: :addNew }, store);
      end

      it "::storeJSON with version:update checks for the JSON object" do
        store = double();
        store.stub(:findJSON).and_return({});
        store.stub(:storeJSON);
        storeJSON(@jsonKey, @jsonObject, { version: :updateLast }, store);
      end

      it "::storeJSON with version:update checks for the JSON object and if found and unchanged do nothing" do
        store = double();
        store.stub(:findJSON).and_return(@jsonRecord);
        storeJSON(@jsonKey, @jsonObject, { version: :updateLast }, store);
      end

      it "::storeJSON with version:update checks for the JSON object and if found but changed the update it" do
        store = double();
        store.stub(:findJSON).and_return({ jsonObject: "silly" });
        store.stub(:updateJSON);
        storeJSON(@jsonKey, @jsonObject, { version: :updateLast }, store);
      end

      it "::storeJSON with version:error checks for the JSON object and if found and unchanged does nothing" do
        store = double();
        store.stub(:findJSON).and_return(@jsonRecord);
        storeJSON(@jsonKey, @jsonObject, { version: :raiseError }, store);
      end

      it "::storeJSON with version:error checks for the JSON object and if found and changed raises a PersistentStore::UpdateError" do
        store = double();
        store.stub(:findJSON).and_return({ jsonObject: "silly" });
        expect {
          storeJSON(@jsonKey, @jsonObject, { version: :raiseError }, store);
        }.to raise_error(PersistentStore::UpdateError)
      end

    end
  end
end; end
