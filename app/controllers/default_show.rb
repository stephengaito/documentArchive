Fandianpf::App.controller do

  get '/show/:content_title', :provides => [ :html, :json ] do | contentTitle |
    @jsonContent = findJSON(contentTitle);
    @jsonContent.merge!({ error: "content(/show/#{contentTitle}) has not been found" }) if @jsonContent.empty?;
    @jsonContent.merge!({ contentTitle: contentTitle });
    render 'default_show'
  end

  put '/show/:content_title', { :provides => [ :json ], 
                                :csrf_protection => false } do | contentTitle |
    request.body.rewind  # in case someone already read it
    jsonObject = JSON.parse request.body.read 
    storeJSON contentTitle, jsonObject
  end

end
