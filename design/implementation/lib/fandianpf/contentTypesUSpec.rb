require 'fandianpf';

module Fandianpf; module Spec;

  # The Fandianpf::Spec::ContentTypesSpec module collects the 
  # specifications for the Fandianpf::ContentTypes module.
  module ContentTypesSpec

    describe ContentTypes do

      it "::registerContentType registers a given content type" do
        contentType    = "AuthorType";
        ctKlassName    = contentType.camelize;
        ctSnakeName    = contentType.underscore;
        ctBasePath     = "contentTypes/"+ctSnakeName; 
        ctViewsPath    = ctBasePath+"/views";
        appViewsPath   = "app/views/"+ctSnakeName;
        ctRequirePath  = ctBasePath+"/"+ctSnakeName;

        kernelMock     = double();
        fileMock       = double();
        fileUtilsMock  = double();
        fandianpfMock  = double();
        authorTypeMock = double();

        kernelMock.should_receive(:require).with(ctSnakeName);
        fileMock.should_receive(:directory?).with(ctViewsPath).and_return(true);
        fileUtilsMock.should_receive(:cp_r).with(ctViewsPath, appViewsPath);
        fandianpfMock.should_receive(:const_get).with(ctKlassName).and_return(authorTypeMock);
        authorTypeMock.should_receive(:install).ordered;
        authorTypeMock.should_receive(:listMigrations).ordered;
        authorTypeMock.should_receive(:doMigrations).ordered;

        ContentTypes.registerContentType(contentType, kernelMock, fileMock, fileUtilsMock, fandianpfMock);

        expect($LOAD_PATH).to include ctBasePath
      end

      it "::registerFields registers the table name and fields associated with this content type" do
        ContentTypes.registerFields(:AuthorType, :AuthorType.to_s.underscore, [ :surname, :von, :firstname, :jr, :institute, :notes ]);

        expect(ContentTypes.isContentType(:AuthorType)).to be_true;

        theFields = ContentTypes.getFields(:AuthorType);
        expect(theFields).to be_kind_of Array
        expect(theFields).to include :surname;
      end

      it "::registerDescription registers a description for this content type"

    end
 
  end

end; end
