-- A Lua template file

-- from file: preamble.tex after line: 400

if not modules then modules = { } end modules ['t-joylol-coalg-templates'] = {
    version   = 1.000,
    comment   = "JoyLoL CoAlgebraic extensions module - templates",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata              = thirddata              or {}
thirddata.joyLoLCoAlgs = thirddata.joyLoLCoAlgs or {}

local coAlgs     = thirddata.joyLoLCoAlgs

local templates  = { }

templates.cHeader = [=[
This is the start of a cHeader template
{{ lookupInDict 'coAlgName }}
This is the end of a cHeader template
]=]

templates.cCode = [=[
This is the start of a cCode template
{{ lookupInDict 'coAlgName }}
This is the end of the cCode template
]=]

templates.joyLoLCode = [=[
This is the start of a joyLoLCode template
{{ lookupInDict 'coAlgName }}
This is the end of the joyLoLCode template
]=]

templates.luaCode = [=[
-- A Lua file (automatically generated)
{{ lookupInDict 'coAlgName }}
This is the end of the luaCode template
]=]

local joyLoL = coAlgs.joyLoL
local pushData, pushProcess = joyLoL.pushData, joyLoL.pushProcess
local pushProcessQuoted = joyLoL.pushProcessQuoted
local popData, popProcess   = joyLoL.popData, joyLoL.popProcess
local newList, newDictionary = joyLoL.newList, joyLoL.newDictionary
local jEval = joyLoL.eval

-----------------------------------------------------------------------------
-- NOTE the following uses raw JoyLoL code to load the templates into the
-- context provided.

-- To understand this code.... **think categorically**

-- In JoyLoL a particular object in the category *is* the structure of the
-- data stack, while a particular arrow in the category *is* the process
-- stack.

-- To understand what these arrows are doing... you read the JoyLoL code
-- in reverse order (from a 'jEval' up).
-----------------------------------------------------------------------------

function coAlgs.loadTemplates(aCtx)
  pushProcess(aCtx, 'addToDict')
  for aKey, aValue in pairs(templates) do
    pushProcess(aCtx, 'addToDict')
    pushProcessQuoted(aCtx, aValue)
    pushProcessQuoted(aCtx, aKey)
  end
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, 'templates')
  jEval(aCtx)
end

interfaces.writestatus('joyLoLCoAlg', 'loaded JoyLoL CoAlg templates')