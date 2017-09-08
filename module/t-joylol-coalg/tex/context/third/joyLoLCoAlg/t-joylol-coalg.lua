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

local joylol     = thirddata.joylol
joylol.theCoAlg  = joylol.theCoAlg  or {}


local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring

local function newCoAlg(coAlgName)
  joylol.theCoAlg[coAlgName] =
    joylol.theCoAlg[coAlgName] or {}
  local theCoAlg        = joylol.theCoAlg[coAlgName]
  theCoAlg.name         = coAlgName
  theCoAlg.words        = theCoAlg.words or {}
  theCoAlg.words.global = {}
end

joylol.newCoAlg = newCoAlg

local function createCoAlg()
end

joylol.createCoAlg = createCoAlg
