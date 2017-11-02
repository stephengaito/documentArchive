-- A Lua file

-- from file: minJoyLoL.tex after line: 0

texio.write_nl("HELLO FROM MINIMAL JOYLOY!")

thirddata.minJoylol = thirddata.minJoylol or { }
local minJoylol     = thirddata.minJoylol

minJoylol.core = { }

minJoylol.core.context = { }

function minJoylol.core.context.setVerbose(aBool) end
function minJoylol.core.context.setDebugging(aBool) end
function minJoylol.core.context.loadFile(aBool) end
function minJoylol.core.context.gitVersion(aBool) end