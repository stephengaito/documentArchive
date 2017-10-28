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

-- local coAlgs     = thirddata.joyLoLCoAlgs
-- coAlgs.theCoAlg  = {}
-- local theCoAlg   = coAlgs.theCoAlg


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

local hasJoyLoL,joyLoL = pcall(require, "joyLoL/joyLoL")
if not hasJoyLoL then
  interfaces.writestatus("joyLoL",
    "Could NOT load joyLoL... loading mininal Lua version instead.")
  joyLoL = require 'joyLoLMinLua/joyLoL'
end

coAlgs.joyLoL = joyLoL

local pushData, pushProcess = joyLoL.pushData, joyLoL.pushProcess
local pushProcessQuoted = joyLoL.pushProcessQuoted
local popData, popProcess   = joyLoL.popData, joyLoL.popProcess
local newList, newDictionary = joyLoL.newList, joyLoL.newDictionary
local jEval = joyLoL.eval

interfaces.writestatus("joyLoL", joyLoL.version())

-----------------------------------------------------------------------------
-- NOTE the following uses raw JoyLoL code to collect the coAlgebra's
-- literate code description.

-- To understand this code.... **think categorically**

-- In JoyLoL a particular object in the category *is* the structure of the
-- data stack, while a particular arrow in the category *is* the process
-- stack.

-- To understand what these arrows are doing... you read the JoyLoL code
-- in reverse order (from a 'jEval' up).
-----------------------------------------------------------------------------

local function addNewDict(aCtx, dictName)
  pushProcess(aCtx, 'addToDict')
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, dictName)
end

local function addNewList(aCtx, listName)
  pushProcess(aCtx, 'addToDict')
  newList(aCtx)
  pushProcess(aCtx, listName)
end

local function addStrToListNamed(aCtx, aStr, listName)
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, aStr) -- need to explicitly quote this string
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, listName)
end

function coAlgs.newCoAlg(coAlgName)
  texio.write_nl('newCoAlg: ['..coAlgName..']')
  theCoAlg               = {}
  theCoAlg.name          = coAlgName
  theCoAlg.ctx           = joyLoL.newContext()
  theCoAlg.hasJoyLoLCode = false;
  theCoAlg.hasLuaCode    = false;
  theCoAlg.hasCHeader    = false;
  theCoAlg.hasCCode      = false;
  --
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, coAlgName)
  pushProcessQuoted(aCtx, 'coAlgName')
  addNewList(aCtx, 'dependsOn')
  addNewList(aCtx, 'wordOrder')
  addNewDict(aCtx, 'words')
  newDictionary(aCtx)
  jEval(aCtx)
  --
  -- add the new word: "global"
  --
  coAlgs.newWord('global')
end

function coAlgs.addDependency(dependencyName)
  texio.write_nl('addDependency: ['..dependencyName..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, dependencyName)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'dependsOn')
  jEval(aCtx)
end

local function writeCodeFile(aCtx, coAlgName, templateName, filePath, fileExt)
  local outFilePath = string.format('%s/%s.%s', filePath, coAlgName, fileExt)
  local outFile = io.open(outFilePath, 'w')
  outFile:write(pp.write(theCoAlg))
  pushProcess(aCtx, 'render')
  pushProcess(aCtx, 'getTemplate')
  pushProcessQuoted(aCtx, templateName)
  jEval(aCtx)
  local renderedBaseTemplate = popData(aCtx)
  texio.write_nl(renderedBaseTemplate)
  outFile:write('\n')
  outFile:write(renderedBaseTemplate)
  outFile:write('\n')
  outFile:close()
end

function coAlgs.createCoAlg()
  texio.write_nl("createCoAlg...")
  if not theCoAlg then return end
  local coAlgName = theCoAlg.name or 'unknown'
  texio.write_nl(string.format('creating JoyLoL CoAlgebra: [%s]', coAlgName))
  --
  local aCtx = theCoAlg.ctx
  coAlgs.loadTemplates(aCtx) -- contains a jEval
  --
  if theCoAlg.hasCHeader    then writeCodeFile(aCtx, coAlgName, 'cHeader',    'build', 'h')   end
  if theCoAlg.hasCCode      then writeCodeFile(aCtx, coAlgName, 'cCode',      'build', 'c')   end
  if theCoAlg.hasLuaCode    then writeCodeFile(aCtx, coAlgName, 'luaCode',    'build', 'lua') end
  if theCoAlg.hasJoyLoLCode then writeCodeFile(aCtx, coAlgName, 'joyLoLCode', 'build', 'joy') end
  --
  texio.write_nl(string.format(' created JoyLoL CoAlgebra: [%s]', coAlgName))
end

function coAlgs.newWord(wordName)
  texio.write_nl('newWord: ['..wordName..']')
  theCoAlg.curWord    = wordName
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'addToDict')
  addNewList(aCtx, 'preData')
  addNewList(aCtx, 'postData')
  addNewList(aCtx, 'preProcess')
  addNewList(aCtx, 'postProcess')
  addNewList(aCtx, 'joyLoLCode')
  addNewList(aCtx, 'cHeader')
  addNewList(aCtx, 'cCode')
  addNewList(aCtx, 'luaCode')
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, wordName) -- need to explicitly quote this string
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'words')
  addStrToListNamed(aCtx, wordName, 'wordOrder')
  jEval(aCtx)
end

function coAlgs.endWord()
  theCoAlg.curWord = 'global'
end

function coAlgs.addPreDataStackDescription(name, condition)
  texio.write_nl('addPreDataStackDescription: ['..name..']['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, name)
  pushProcessQuoted(aCtx, 'name')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'preData')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPostDataStackDescription(condition)
  texio.write_nl('addPostDataStackDescription: ['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'postData')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPreProcessStackDescription(name, condition)
  texio.write_nl('addPreProcessStackDescription: ['..name..']['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, name)
  pushProcessQuoted(aCtx, 'name')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'preProcess')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPostProcessStackDescription(condition)
  texio.write_nl('addPostProcessStackDescription: ['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'postProcess')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addJoyLoLCode(bufferName)
  texio.write_nl('addJoyLoLCode: ['..bufferName..']')
  theCoAlg.hasJoyLoLCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'joyLoLCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addCHeader(bufferName)
  texio.write_nl('addCHeader: ['..bufferName..']')
  theCoAlg.hasCHeader = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'cHeader')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addCCode(bufferName)
  texio.write_nl('addCCode: ['..bufferName..']')
  theCoAlg.hasCCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'cCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addLuaCode(bufferName)
  texio.write_nl('addLuaCode: ['..bufferName..']')
  theCoAlg.hasLuaCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'luaCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

coAlgs.joyLoL = joyLoL

interfaces.writestatus('joyLoL', "loaded JoyLoL CoAlgs")

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
thirddata.joylol = require 'joylol.core.context'
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
  joylol.core.lua.loadFile("config")
end