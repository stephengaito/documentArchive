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
coAlgs.theCoAlg  = {}
local theCoAlg   = coAlgs.theCoAlg

local pp = require('pl/pretty')

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

local pushData, pushProcess = joyLoL.pushData, joyLoL.pushProcess
local pushProcessQuoted = joyLoL.pushProcessQuoted
local popData, popProcess   = joyLoL.popData, joyLoL.popProcess
local newList, newDictionary = joyLoL.newList, joyLoL.newDictionary
local jEval = joyLoL.eval

--[=[
local function jEval(aCtx)
  texio.write_nl("----jEval----")
  texio.write_nl(pp.write(aCtx))
  joyLoL.eval(aCtx)
  texio.write_nl(pp.write(aCtx))
  texio.write_nl("-------------")
end
--]=]

interfaces.writestatus("joyLoL", joyLoL.version())

function coAlgs.newCoAlg(coAlgName)
  texio.write_nl('newCoAlg: ['..coAlgName..']')
  theCoAlg           = {}
  theCoAlg.name      = coAlgName
  theCoAlg.dependsOn = {}
  theCoAlg.words     = {}
  theCoAlg.wordOrder = {}
  theCoAlg.ctx       = joyLoL.newContext()
  local aCtx = theCoAlg.ctx
  -- Create main dictionary
  newDictionary(aCtx)
  jEval(aCtx)
  -- Create dependsOn list
  pushProcess(aCtx, 'addToDict')
  newList(aCtx)
  pushProcess(aCtx, 'dependsOn')
  jEval(aCtx)
  -- Create wordOrder list
  pushProcess(aCtx, 'addToDict')
  newList(aCtx)
  pushProcess(aCtx, 'wordOrder')
  jEval(aCtx)
  -- Create words dictionary
  pushProcess(aCtx, 'addToDict')
  newDictionary(aCtx)
  pushProcess(aCtx, 'words')
  jEval(aCtx)
  -- add the new word: "global"
  coAlgs.newWord('global')
end

function coAlgs.addDependency(dependencyName)
  texio.write_nl('addDependency: ['..dependencyName..']')
  local dependsOn = theCoAlg.dependsOn
  dependsOn[#dependsOn+1] = dependencyName
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, dependencyName)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'dependsOn')
  jEval(aCtx)
end


function coAlgs.createCoAlg()
  texio.write_nl("createCoAlg...")
  if not theCoAlg then return end
  if not theCoAlg.name then theCoAlg.name = 'unknown' end
  local outFilePath = string.format('build/%s.txt', theCoAlg.name)
  texio.write_nl(string.format('creating JoyLoL CoAlgebra: [%s]', outFilePath))
  local outFile = io.open(outFilePath, 'w')
  outFile:write(pp.write(theCoAlg))
  outFile:close()
  texio.write_nl(string.format(' created JoyLoL CoAlgebra: [%s]', outFilePath))
end

local function addNewList(aCtx, listName)
  pushProcess(aCtx, 'addToDict')
  newList(aCtx)
  pushProcess(aCtx, listName)
  jEval(aCtx)
end

local function addStrToListNamed(aCtx, aStr, listName)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, listName)
  jEval(aCtx)
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, aStr) -- need to explicitly quote this string
  jEval(aCtx)
  popData(aCtx)
end

function coAlgs.newWord(wordName)
  texio.write_nl('newWord: ['..wordName..']')
  theCoAlg.curWord    = wordName
  theCoAlg.words[wordName] = {}
  theCoAlg.wordOrder[#theCoAlg.wordOrder+1] = wordName
  
  local theWord       = theCoAlg.words[wordName]
  theWord.name        = wordName
  theWord.preData     = {}
  theWord.postData    = {}
  theWord.preProcess  = {}
  theWord.postProcess = {}
  theWord.joyLoLCode  = {}
  theWord.cHeader     = {}
  theWord.cCode       = {}
  theWord.luaCode     = {}
  local aCtx = theCoAlg.ctx
  addStrToListNamed(aCtx, wordName, 'wordOrder')
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, wordName) -- need to explicitly quote this string
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
  addNewList(aCtx, 'preData')
  addNewList(aCtx, 'postData')
  addNewList(aCtx, 'preProcess')
  addNewList(aCtx, 'postProcess')
  addNewList(aCtx, 'joyLoLCode')
  addNewList(aCtx, 'cHeader')
  addNewList(aCtx, 'cCode')
  addNewList(aCtx, 'luaCode')
  --
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'addToDict')
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
