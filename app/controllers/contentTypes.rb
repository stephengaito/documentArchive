Fandianpf::App.controller do

# NOTE CamelCase is NOT allowed in URL keys.

  get '/show/:content_title', :provides => [ :html, :json ] do | contentTitle |
    @jsonContent = findJSON(contentTitle);
    @jsonContent.merge!({ error: "content(/show/#{contentTitle}) has not been found" }) if @jsonContent.empty?;
    @jsonContent.merge!({ contentTitle: contentTitle });
    render 'default_show'
  end

  put '/add/:content_title', { :provides => [ :json ], 
                                :csrf_protection => false } do | contentTitle |
    request.body.rewind  # in case someone already read it
    jsonObject = JSON.parse request.body.read 
    storeJSON contentTitle, jsonObject, { version: :addNew };
  end

  put '/update/:content_title', { :provides => [ :json ], 
                                :csrf_protection => false } do | contentTitle |
    request.body.rewind  # in case someone already read it
    jsonObject = JSON.parse request.body.read 
    storeJSON contentTitle, jsonObject, { version: :updateLast };
  end

  get '/contentTypes/:content_type', { :provides => [ :html, :json ] } do | contentType |
    @contentTypeDescription = getContentTypeDescription(contentType.to_sym);
    render 'contentTypeDescription'
  end

  get '/contentTypes', :provides => [ :html, :json ] do
    @contentTypesList = getContentTypes;
    render 'contentTypesList'
  end

  get '/contentFields/:content_field', { :provides => [ :html, :json ] } do | contentField |
    @contentFieldDescription = getContentFieldDescription(contentField.to_sym);
    render 'contentFieldDescription'
  end

  get '/contentFields', :provides => [ :html, :json ] do
    @contentFieldsList = getContentFields;
    render 'contentFieldsList'
  end

end
