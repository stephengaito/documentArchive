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
  commitDate      = "2017-11-30",
  commitShortHash = "d7d5071",
  commitLongHash  = "d7d5071bb0fb2d603dbad42458be31a57cdb7b2f",
  subject         = "recreated a minimal initial dictionaries coAlg",
  notes           = ""
}

-- from file: overview.tex after line: 0

options.gitVersion = gitVersion