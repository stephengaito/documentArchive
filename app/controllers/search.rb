Fandianpf::App.controller do

require 'pp';

# NOTE CamelCase is NOT allowed in URL keys.

  get '/search/*search_keywords', :provides => [ :html, :json ] do | searchKeywords |

    @searchPattern = env['PATH_INFO'];
    contentTypeOrField = "";
    contentTypeOrField = searchKeywords[0] if 0 < searchKeywords.length;
    if isContentType(contentTypeOrField) then
      searchKeywords[0].sub!(/$/, '!');
    elsif isField(contentTypeOrField) then
      searchKeywords[0].sub!(/$/, '!');
    end

    pp searchKeywords;

    @searchKeywords = searchKeywords;
    @searchResults = searchJSON(searchKeywords);
    render 'search_results'
  end

end
