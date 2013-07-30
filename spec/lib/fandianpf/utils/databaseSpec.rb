require 'fandianpf/utils/database';

module Fandianpf; module Spec
  module Utils

    describe Fandianpf::Utils do

      it "#getDataMapperURI should return standard sqlite uri if no settings found" do
        Fandianpf::Utils.getDataMapperURI(:production).should  eql "sqlite3://#{Dir.getwd}/db/fandianpf_production.sqlite";
        Fandianpf::Utils.getDataMapperURI(:test).should        eql "sqlite3://#{Dir.getwd}/db/fandianpf_test.sqlite";
        Fandianpf::Utils.getDataMapperURI(:development).should eql "sqlite3://#{Dir.getwd}/db/fandianpf_development.sqlite";
      end

      it "#getDataMapperURI should specified URI if specified in settings" do
        Fandianpf::Utils.getDataMapperURI(:test, { :dataMapperTestURI => 'testURI' }).should eql "testURI";
      end

      it "#getDataMapperURI should not alter sqlite path if it does not begin with '/./'" do
        Fandianpf::Utils.getDataMapperURI(:test, { :dataMapperTestURI => 'sqlite3:///testURI' }).should eql 'sqlite3:///testURI';
      end

      it "#getDataMapperURI should pre-pend current working directory to sqlite path if the settings path starts with '/./'" do
        uri = Fandianpf::Utils.getDataMapperURI(:test, { :dataMapperTestURI => 'sqlite3:///./testURI' });
        uri.should eql "sqlite3://#{Dir.getwd}/testURI";
      end

      it "#getDataMapperURI should ensure all filesystem paths exist for SQLite databases" do
        # This is currently tested by Cucumber features
        #
        # This should be tested with an RSpec-Mock of FileUtils which 
        # is made difficult due to the fact that FileUtils is a system 
        # constant.
      end
    end
  end
end; end
