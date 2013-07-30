require 'fandianpf/utils/settings';

module Fandianpf; module Spec
  module Utils

    describe Fandianpf::Utils do

      it "#toSymbolHash should recursively change all string keys to symbols" do
        testHash = { 'level0' => { 'level1' => { 'level2' => 'test' } } };
        Fandianpf::Utils.toSymbolHash(testHash);
        testHash.should have_key :level0
        testHash[:level0].should be_kind_of Hash
        testHash[:level0].should have_key :level1
        testHash[:level0][:level1].should be_kind_of Hash
        testHash[:level0][:level1].should have_key :level2
        testHash[:level0][:level1][:level2].should eql 'test'
      end

      it "#managePadrinoOptionsAndSettings with no cmdLineOptions should return required padrinoOptions and an empty padrinoSettings" do 
        padrinoOptions, padrinoSettings = Fandianpf::Utils.managePadrinoOptionsAndSettings();
        padrinoOptions.should be_kind_of Hash
        padrinoOptions.should have_key :host
        padrinoOptions[:host].should eql '127.0.0.1'
        padrinoOptions.should have_key :port
        padrinoOptions[:port].should eql 3000
        padrinoSettings.should be_kind_of Hash
        padrinoSettings.should be_empty
      end
    end
  end
end; end
