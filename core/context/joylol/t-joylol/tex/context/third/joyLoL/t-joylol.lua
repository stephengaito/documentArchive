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

thirddata        = thirddata        or {}
thirddata.joylol = thirddata.joylol or {}

local joylol   = thirddata.joylol

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring

-- **Problem**: we can not assume that a user *has* a compiled and working
-- C based JoyLoL. This is the "Bootstrapping (Compiler)" problem (see
-- Wikipedia). We solve this problem by writing a minimal joyLoL
-- interpreter in Lua.

-- SO we first check to see if the joyLoL (C shared libraries) exists and
-- can be required, if it can not be loaded, we load the joyLoLMinLua
-- version instead.

-- The following conditional require is adapted from: shuva's answer to
--  "How to check if a module exists in Lua?"
-- see: http://stackoverflow.com/a/22686090

-- local hasJoyLoL,joyLoL = pcall(require, "joyLoL/joyLoL")
-- if not hasJoyLoL then
-- interfaces.writestatus("joyLoL",
--     "Could NOT load joyLoL... loading mininal Lua version instead.")
--  joyLoL = require 'joyLoLMinLua/joyLoL'
-- end

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