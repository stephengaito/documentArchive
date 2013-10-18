require 'support/uspec_helper';

require 'fandianpf/utils/options';

module Fandianpf; 
  
  # The Fandianpf::Spec module collects the specifications for the 
  # FandianPF system.
  module Spec

  # The Fandianpf::Spec::Utils module collects the specifications of 
  # the various utility type methods used by the FandianPF system.
  module Utils

  # The Fandianpf::Spec::Utils::OptionsSpec module collects the 
  # specifications for the Fandianpf::Utils::Options class.
  module OptionsSpec
    include Fandianpf::Utils;

    describe Options do

      before(:each) do
        Options.clear;
        Options.setCommandLineArguments(["-e", "test", "--chdir", "/tmp", "-P", "2000", "--settings", "config/otherSettings.yml" ]);
        yaml = { someKey: "someValue", port: 2001 };
        @yamlClass = double();
        @yamlClass.stub(:load_file).and_return(yaml);
        @fileClass = double();
        @fileClass.stub(:readable?).and_return(true);
      end

      it "::toSymbolHash recursively changes all string keys to symbols" do
        testHash = { 'level0' => { 'level1' => { 'level2' => 'test' } } };
        Fandianpf::Utils::Options.toSymbolHash(testHash);
        expect(testHash).to have_key :level0
        expect(testHash[:level0]).to be_kind_of Hash
        expect(testHash[:level0]).to have_key :level1
        expect(testHash[:level0][:level1]).to be_kind_of Hash
        expect(testHash[:level0][:level1]).to have_key :level2
        expect(testHash[:level0][:level1][:level2]).to eql 'test'
      end

      it "::parseCommandLineArguments parses the command line arguments into Options" do
        Options.setCommandLineArguments([]);
        Options.parseCommandLineArguments();
        expect(Options).to have_key(:port);
        expect(Options[:port]).to be 3000;
        expect(Options).not_to have_key(:settings);
      end

      it "::parseCommandLineArguments parses commplete set of command line arguments" do
        Options.parseCommandLineArguments();
        expect(Options).to have_key(:environment);
        expect(Options[:environment]).to be :test;
        expect(Options).to have_key(:chdir);
        expect(Options[:chdir]).to eq "/tmp";
        expect(Options).to have_key(:port);
        expect(Options[:port]).to be 2000;
        expect(Options).to have_key(:settings);
        expect(Options[:settings]).to eq "config/otherSettings.yml";
      end

      it "::loadSettings loads the yaml settings file" do
        @fileClass.should_receive(:readable?).with("config/settings.yml");
        @yamlClass.should_receive(:load_file).with("config/settings.yml");
        Options.loadSettings(@yamlClass, @fileClass);
        expect(Options).to have_key(:someKey);
        expect(Options[:someKey]).to eq "someValue";
        expect(Options).to have_key(:port);
        expect(Options[:port]).to be 2001;
      end

      it "::loadSettings keeps command line arguments" do
        @fileClass.should_receive(:readable?).with("config/otherSettings.yml");
        @yamlClass.should_receive(:load_file).with("config/otherSettings.yml");
        Options.parseCommandLineArguments();
        Options.loadSettings(@yamlClass, @fileClass);
        expect(Options).to have_key(:someKey);
        expect(Options[:someKey]).to eq "someValue";
        expect(Options).to have_key(:port);
        expect(Options[:port]).to be 2000;
      end

      it "::getSettings returns a hash of the non-command line options" do
        Options.parseCommandLineArguments();
        Options.loadSettings(@yamlClass, @fileClass);
        settings = Options.getSettings();
        expect(settings).to be_kind_of(Hash);
        expect(settings).not_to be_empty;
        expect(settings).not_to have_key(:port);
        expect(Options).to have_key(:port);
        expect(settings).to have_key(:someKey);
        expect(settings[:someKey]).to eq "someValue";
      end


      it "::getOptions returns a hash of the current collection of options" do
        Options.parseCommandLineArguments();
        Options.loadSettings(@yamlClass, @fileClass);
        options = Options.getOptions();
        expect(options).to be_kind_of(Hash);
        expect(options).not_to be_empty;
        expect(options).to have_key(:port);
        expect(options).to have_key(:someKey);
      end
    end
  end
end; end; end
