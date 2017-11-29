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

thirddata          = thirddata        or {}
thirddata.joylol   = thirddata.joylol or {}
local joylol       = thirddata.joylol
joylol.options     = joylol.options or {}
local options      = joylol.options

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

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring

-- from file: gitVersion-lua.tex after line: 0

local gitVersion = {
  authorName      = "Stephen Gaito",
  commitDate      = "2017-11-28",
  commitShortHash = "fe921cd",
  commitLongHash  = "fe921cdda8f95ed19cab2bc33de4827fa5df6283",
  subject         = "added initial crossCompilers coAlg",
  notes           = ""
}

-- from file: luaMain.tex after line: 0

-- joylol interpreter embedded in ConTeXt

-- Start by adding the standard joylol CoAlg locations to the Lua search
-- paths

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

-- **Problem**: we can not assume that a user *has*
-- a compiled and working C based JoyLoL. This is
-- the "Bootstrapping (Compiler)" problem (see
-- Wikipedia). We solve this problem by writing a
-- minimal joyLoL interpreter in Lua.

-- SO we first check to see if the joyLoL (C shared
-- libraries) exists and can be required, if it can
-- not be loaded, we load the joyLoLMinLua version
-- instead.

-- The following conditional require is adapted
-- from: shuva's answer to
--   "How to check if a module exists in Lua?"
-- see: http://stackoverflow.com/a/22686090
 
local hasJoylol, loadedJoylol =
  pcall(require, 'joylol.core.context')
if not hasJoylol then
  interfaces.writestatus("joyLoL",
    "Could NOT load joyLoL... loading mininal Lua version instead.")
  lua.registercode('t-joylol-minimal')
  loadedJoylol = thirddata.minJoylol
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