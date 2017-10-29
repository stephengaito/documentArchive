-- A Lua file

-- from file: preamble.tex after line: 50

-- This is the lua code associated with t-joylol-opts.mkiv

if not modules then modules = { } end modules ['t-joylol-opts'] = {
    version   = 1.000,
    comment   = "joylol loading options - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata        = thirddata        or {}
thirddata.joylol = thirddata.joylol or {}

local joylol   = thirddata.joylol
joylol.options = joylol.options or {}

local options  = joylol.options

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring

-- from file: luaMain.tex after line: 0

-- joylol interpreter embedded in ConTeXt

-- Start by adding the standard joylol CoAlg locations to the Lua search
-- paths

local joylolPaths = {
  os.getenv('HOME')..'/.joylol/?.lua',
  '/usr/local/lib/joylol/?.lua',
  '/usr/lib/joylol/?.lua',
  package.path
}
package.path = table.concat(joylolPaths, ';')

local joylolCPaths = {
  os.getenv('HOME')..'/.joylol/?.so',
  '/usr/local/lib/joylol/?.so',
  '/usr/lib/joylol/?.so',
  package.path
}
package.cpath = table.concat(joylolCPaths, ';')

-- argStr = '|'..table.concat(arg, '|')..'|'
-- verbose = argStr:match('|%-v|');

-- if verbose then print('loading [joylol.core.context]') end
-- thirddata.joylol = require 'joylol.core.context'
-- if verbose then print('loaded [joylol.core.context]\n') end

loadConfiguration = true
 
while(0 < #arg) do
  anArg = table.remove(arg, 1)
  if anArg:match('-h') then
    print(table.concat(helpText, '\n'))
    os.exit(0);
  elseif anArg:match('-i') then
    loadConfiguration = false
  elseif anArg:match('-q') then
    joylol.core.lua.setVerbose(false)
  elseif anArg:match('-v') then
    joylol.core.lua.setVerbose(true)
  else
    optArg = table.remove(arg, 1)
    table.insert(loadFiles, optArg)
  end
end

if (loadConfiguration) then
--  joylol.core.lua.loadFile("config")
end