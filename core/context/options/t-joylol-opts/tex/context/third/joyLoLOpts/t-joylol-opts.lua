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

-- from file: overview.tex after line: 0

-- joylol loader options

options.verbose    = false
options.debug      = false
options.configFile = 'config'
options.userPath   = os.getenv('HOME')..'/.joylol'
options.localPath  = '/usr/local/lib/joylol'
options.systemPath = '/usr/lib/joylol'

-- from file: gitVersion-lua.tex after line: 0

local gitVersion = {
  authorName      = "Stephen Gaito",
  commitDate      = "2018-01-13",
  commitShortHash = "725662f",
  commitLongHash  = "725662f50c4fca8368bd0f6c4c24cf2ca59e20e9",
  subject         = "begun process of switching to standalone release files instead of minLuaJoyLoL",
  notes           = ""
}

-- from file: overview.tex after line: 0

options.gitVersion = gitVersion