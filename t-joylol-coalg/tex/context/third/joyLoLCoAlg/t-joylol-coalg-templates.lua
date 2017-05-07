-- A Lua file

if not modules then modules = { } end modules ['t-joylol-coalg'] = {
    version   = 1.000,
    comment   = "JoyLoLCoAlgs - templates",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata              = thirddata              or {}
thirddata.joyLoLCoAlgs = thirddata.joyLoLCoAlgs or {}

local coAlgs     = thirddata.joyLoLCoAlgs
coAlgs.templates = {}
local templates  = coAlgs.templates

local pp = require('pl/pretty')

interfaces.writestatus('joyLoL', 'loaded JoyLoL CoAlg templates')

templates.base = [=[
This is the start of a test template
{{ }}
This is the end of a test template
]=]