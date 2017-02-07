-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

-- inspired by http://lua-users.org/wiki/SplitJoin
function M.split(aString, sep)
  local fields = {}
  local sep = sep or ":"
  local pattern = string.format("([^%s]+)", sep)
  aString:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

return M
