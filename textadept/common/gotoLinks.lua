-- Copyright 2017 Stephen Gaito. See License.md

M = {}

M.links     = {} -- array of all links
M.linkUrls  = {} -- table of linkName->linkUrl

local function on_selection(list, item)
  local linkName = item[1]
  list:close()
  textadept.menu.open_page(M.linkUrls[linkName])
end

local function trimStr(aString)
  return aString:match("^[ \t]*(.+)[ \t]*$")
  end

function M.goto_link()
  local lexerName = buffer:get_lexer(false)
  M.links     = {}
  M.linkUrls  = {}
  local linkState = 1
  local linkName  = nil
  local linkUrl   = nil
  local linkDesc  = {}
  for line in  io.lines(_USERHOME .. '/modules/' .. lexerName .. '/links.txt') do
    if not line:match("^[ t]*#") then
      if line:match("^[ \t]*$") then -- we have finished a link
        if linkName then
          M.links[#links+1] = {linkName, linkDesc:concat(" ")}
          M.linkUrls[linkName] = linkUrl
          linkState = 1 -- restart
          linkName  = nil
          linkUrl   = nil
          linkDesc  = {}
        end
      else -- we are in the middle of a link...
        if linkState == 1 then
          linkName = trimStr(line)
          linkState = 2
        elseif linkState == 2 then
          linkUrl = trimStr(line)
          linkState = 3
        else
          aDesc = trimStr(line)
          if aDesc then
            linkDesc[#linkDesc+1] = aDesc
          end
        end
      end
    end
  end
  
  -- add last link
  if linkName then
    links[#links+1] = {linkName, linkDesc:concat(" ")}
    linkUrls[linkName] = linkUrl
  end
  
  -- now show in a reduxlist
  if #links > 0 then
    local list = reduxlist.new('Go to link')
    list.items = links
    list.on_selection = on_selection
    list.column_styles = { reduxstyle.default}
    list.show()
  end
end

return M
