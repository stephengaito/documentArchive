-- A Lua file

-- from file: preamble.tex after line: 900

-- A Lua file

local pp = { }

-- nil, boolean, number, string, function, userdata, thread, and table

local tInsert, tSort = table.insert, table.sort

local function compareKeyValues(a, b)
  return (a[1] < b[1])
end

local function toString(anObj, indent)
  local result = ""
  indent = indent or ""
  if type(anObj) == 'nil' then
    result = 'nil'
  elseif type(anObj) == 'boolean' then
    if anObj then result = 'true' else result = 'false' end
  elseif type(anObj) == 'number' then
    result = tostring(anObj)
  elseif type(anObj) == 'string' then
    result = '"'..anObj..'"'
  elseif type(anObj) == 'function' then
    result = tostring(anObj)
  elseif type(anObj) == 'userdata' then
    result = tostring(anObj)
  elseif type(anObj) == 'thread' then
    result = tostring(anObj)
  elseif type(anObj) == 'table' then
    local origIndent = indent
    indent = indent..'  '
    result = '{\n'
    for i, aValue in ipairs(anObj) do
      result = result..indent..toString(aValue, indent)..',\n'
    end
    local theKeyValues = { }
    for aKey, aValue in pairs(anObj) do
      if type(aKey) ~= 'number' or aKey < 1 or #anObj < aKey then
        tInsert(theKeyValues, { toString(aKey), aKey, toString(aValue, indent) })
      end
    end
    tSort(theKeyValues, compareKeyValues)
    for i, aKeyValue in ipairs(theKeyValues) do
      result = result..indent..'['..aKeyValue[1]..'] = '..aKeyValue[3]..',\n'
    end
    result = result..origIndent..'}'
  else
    os.exit('UNKNOWN TYPE')
  end
  return result
end

pp.toString = toString

return pp