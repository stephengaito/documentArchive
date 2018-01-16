-- A Lua file

-- from file: preamble.tex after line: 50

-- This is the lua code associated with t-joylol.mkiv

if not modules then modules = { } end modules ['t-joylol'] = {
    version   = 1.000,
    comment   = "joylol programming language - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

local function setDefs(varVal, selector, defVal)
  if not defVal then defVal = { } end
  varVal[selector] = varVal[selector] or defVal
  return varVal[selector]
end

thirddata          = thirddata        or {}
local joylol       = setDefs(thirddata, 'joylol')
local options      = setDefs(joylol, 'options')

options.verbose    =
  options.verbose    or false
options.debug      =
  options.debug      or false
options.quiet      =
  options.quiet      or false
options.configFile =
  options.configFile or 'config'
options.userPath   =
  options.userPath   or os.getenv('HOME')..'/.joylol'
options.localPath  =
  options.localPath  or '/usr/local/lib/joylol'
options.systemPath =
  options.systemPath or '/usr/lib/joylol'
options.minimalJoylol =
  options.minimalJoylol or false

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring
 
local function compareKeyValues(a, b)
  return (a[1] < b[1])
end

local function prettyPrint(anObj, indent)
  local result = ""
  indent = indent or ""
  if type(anObj) == 'nil' then
    result = 'nil'
  elseif type(anObj) == 'boolean' then
    if anObj then result = 'true' else result = 'false' end
  elseif type(anObj) == 'number' then
    result = toStr(anObj)
  elseif type(anObj) == 'string' then
    result = '"'..anObj..'"'
  elseif type(anObj) == 'function' then
    result = toStr(anObj)
  elseif type(anObj) == 'userdata' then
    result = toStr(anObj)
  elseif type(anObj) == 'thread' then
    result = toStr(anObj)
  elseif type(anObj) == 'table' then
    local origIndent = indent
    indent = indent..'  '
    result = '{\n'
    for i, aValue in ipairs(anObj) do
      result = result..indent..prettyPrint(aValue, indent)..',\n'
    end
    local theKeyValues = { }
    for aKey, aValue in pairs(anObj) do
      if type(aKey) ~= 'number' or aKey < 1 or #anObj < aKey then
        tInsert(theKeyValues,
          { prettyPrint(aKey), aKey, prettyPrint(aValue, indent) })
      end
    end
    tSort(theKeyValues, compareKeyValues)
    for i, aKeyValue in ipairs(theKeyValues) do
      result = result..indent..'['..aKeyValue[1]..'] = '..aKeyValue[3]..',\n'
    end
    result = result..origIndent..'}'
  else
    result = 'UNKNOWN TYPE: ['..toStr(anObj)..']'
  end
  return result
end

-- from file: gitVersion-lua.tex after line: 0

local gitVersion = {
  authorName      = "Stephen Gaito",
  commitDate      = "2018-01-16",
  commitShortHash = "1b79fe5",
  commitLongHash  = "1b79fe50a31c6930ddda24a00d5edf4dcd8d6e9d",
  subject         = "improved creation of required directories; continued move towards new bootstrap process",
  notes           = ""
}

-- from file: luaMain.tex after line: 0

-- joylol interpreter embedded in ConTeXt

-- Start by adding the standard joylol CoAlg locations to the Lua search
-- paths

texio.write_nl("----------JoyLoL options-----------")
texio.write_nl(prettyPrint(options))
texio.write_nl("-----------------------------------")

local joylolPaths = {
  options.userPath..'/?.lua',
  options.localPath..'/?.lua',
  options.systemPath..'/?.lua',
  package.path
}
package.path = table.concat(joylolPaths, ';')

local joylolCPaths = {
  options.userPath..'/?.so',
  options.localPath..'/?.so',
  options.systemPath..'/?.so',
  package.path
}
package.cpath = table.concat(joylolCPaths, ';')

if options.verbose then print('loading [joylol.core.context]') end

local hasJoylol, loadedJoylol =
  pcall(require, 'joylol.core.context')
if not hasJoylol then
  interfaces.writestatus("joyLoL",
    "Could NOT load ANSI-C joyLoL....")
  error('Could NOT load ANSI-C JoyLoL')
end
thirddata.joylol = loadedJoylol

if options.verbose then print('loaded [joylol.core.context]\n') end

local joylol = thirddata.joylol

joylol.core.context.setVerbose(options.verbose)
joylol.core.context.setDebugging(options.debug)

if (options.configFile) then
  joylol.core.context.loadFile(options.configFile)
end

-- from file: luaInterface.tex after line: 50

local function evalBuffer(bufferName)
  local bufferContents =
    buffers.getcontent(bufferName):gsub("\13", "\n")
  joylol.core.context.evalString(bufferContents)
end

joylol.core.context.evalBuffer = evalBuffer