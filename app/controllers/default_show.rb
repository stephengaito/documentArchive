Fandianpf::App.controller do


#  get '/show/:contentTitle', :provides => [ :html, :json ] do | contentTitle |
  get '/show/test', :provides => [ :html, :json ] do
    contentTitle = 'test';
  @persistentData ||= {};
  @persistentData[:test] = { someKey: 'some thing' };
    contentTitleSym = contentTitle.to_sym;
    @contentJson = { error: "content(/show/#{contentTitle}) has not been found" };
    @contentJson = @persistentData[contentTitleSym].merge({ contentTitle: contentTitle }) if @persistentData.has_key? contentTitleSym;
    render 'default_show'
  end

#  put '/show/:contentTitle' do | contentTitle |
  put '/show/test' do
    contentTitle = 'test';
    request.body.rewind  # in case someone already read it
    @persistentData[contentTitle.to_sym] = JSON.parse request.body.read
  end

end
