require 'fandianpf/utils/settings';

module Fandianpf; 
  
  # The Fandianpf::Spec module collects the specifications for the 
  # FandianPF system.
  module Spec

  # The Fandianpf::Spec::Utils module collects the specifications of 
  # the various utility type methods used by the FandianPF system.
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

      it "#managePadrinoOptionsAndSettings with cmdLineOptions should return required padrinoOptions merged with cmdLineOptions and an empty padrinoSettings" do 
        padrinoOptions, padrinoSettings = Fandianpf::Utils.managePadrinoOptionsAndSettings({ :host => '127.0.0.2', :debug => true });
        padrinoOptions.should be_kind_of Hash
        padrinoOptions.should have_key :host
        padrinoOptions[:host].should eql '127.0.0.2'
        padrinoOptions.should have_key :port
        padrinoOptions[:port].should eql 3000
        padrinoOptions.should have_key :debug
        padrinoOptions[:debug].should be_true
        padrinoSettings.should be_kind_of Hash
        padrinoSettings.should be_empty
      end

      it "#managePadrinoOptionsAndSettings with cmdLineOptions and config/settings.yml file should return non empty padrinoOptions and padrinoSettings" do 
        # This is currently tested by Cucumber features
        #
        # This should be tested with an RSpec-Mock of YAML which is 
        # made difficult due to the fact that YAML is a system 
        # constant.
        #
        # In particular we need to ensure that cmdLineOptionKeys 
        # defined in condfig/settings.yml are removed from 
        # padrinoSettings and put in padrinoOptions.
      end
    end
  end
end; end
