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
  commitDate      = "2017-12-02",
  commitShortHash = "6a233f5",
  commitLongHash  = "6a233f59fa9cdf055aacc5596fb50f5d69ee72bb",
  subject         = "started refactoring into new class system",
  notes           = ""
}

-- from file: overview.tex after line: 0

options.gitVersion = gitVersion