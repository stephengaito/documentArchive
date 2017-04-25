-- A Lua file

if not modules then modules = { } end modules ['t-joylol-coalg'] = {
    version   = 1.000,
    comment   = "JoyLoLCoAlgs",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata              = thirddata              or {}
thirddata.joyLoLCoAlgs = thirddata.joyLoLCoAlgs or {}

local coAlgs     = thirddata.joyLoLCoAlgs

interfaces.writestatus('joyLoL', "loaded JoyLoL CoAlgs")

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

local hasJoyLoL,joyLoL = pcall(require, "joyLoL/joyLoL")
if not hasJoyLoL then
  interfaces.writestatus("joyLoL",
    "Could NOT load joyLoL... loading mininal Lua version instead.")
  joyLoL = require 'joyLoLMinLua/joyLoL'
end

interfaces.writestatus("joyLoL", joyLoL.version())

function joyLoL.writeBuffer(bufferName)
  texio.write_nl(buffers.getcontent(bufferName))
end

coAlgs.joyLoL = joyLoL
