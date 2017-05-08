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
local popData, popProcess   = joyLoL.popData, joyLoL.popProcess
local newList, newDictionary = joyLoL.newList, joyLoL.newDictionary
local jEval = joyLoL.eval

interfaces.writestatus("joyLoL", joyLoL.version())

function coAlgs.newCoAlg(coAlgName)
  theCoAlg           = {}
  theCoAlg.name      = coAlgName
  theCoAlg.dependsOn = {}
  theCoAlg.words     = {}
  theCoAlg.wordOrder = {}
  theCoAlg.ctx       = joyLoL.newContext()
  local aCtx = theCoAlg.ctx
  -- Create main dictionary
  newDictionary(aCtx)
  -- Create dependsOn list
  pushData(aCtx, 'dependsOn')
  newList(aCtx)
  pushProcess(aCtx, 'addToDict')
  jEval(aCtx)
  -- Create wordOrder list
  pushData(aCtx, 'wordOrder')
  newList(aCtx)
  pushProcess(aCtx, 'addToDict')
  jEval(aCtx)
  -- Create words dictionary
  pushData(aCtx, 'words')
  newDictionary(aCtx)
  pushProcess(aCtx, 'addToDict')
  jEval(aCtx)
  -- add the new word: "global"
  coAlgs.newWord('global')
end

function coAlgs.addDependency(dependencyName)
  local dependsOn = theCoAlg.dependsOn
  dependsOn[#dependsOn+1] = dependencyName
end


function coAlgs.createCoAlg()
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
  pushData(aCtx, listName)
  newList(aCtx)
  pushProcess(aCtx, 'addToDict')
  jEval(aCtx)
end

local function addStrToListNamed(aCtx, aStr, listName)
  pushData   (aCtx, listName)
  pushProcess(aCtx, 'lookupInDict')
  jEval(aCtx)
  pushData   (aCtx, aStr)
  pushProcess(aCtx, 'appendToEndList')
  jEval(aCtx)
  popData(aCtx)
end

function coAlgs.newWord(wordName)
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
  pushData(aCtx, wordName)
  newDictionary(aCtx)
  addNewList(aCtx, 'preData')
  addNewList(aCtx, 'postData')
  addNewList(aCtx, 'preProcess')
  addNewList(aCtx, 'postProcess')
  addNewList(aCtx, 'joyLoLCode')
  addNewList(aCtx, 'cHeader')
  addNewList(aCtx, 'cCode')
  addNewList(aCtx, 'luaCode')
  pushProcess(aCtx, 'addToDict')
  --jEval(aCtx)
end

function coAlgs.endWord()
  theCoAlg.curWord = 'global'
end

function coAlgs.addPreDataStackDescription(name, condition)
  local theStack = theCoAlg.words[theCoAlg.curWord].preData
  theStack[#theStack+1] = { }
  local aDesc = theStack[#theStack]
  aDesc.name = name
  aDesc.condition = condition
end

function coAlgs.addPostDataStackDescription(condition)
  local theStack = theCoAlg.words[theCoAlg.curWord].postData
  theStack[#theStack+1] = { }
  local aDesc = theStack[#theStack]
  aDesc.condition = condition
end

function coAlgs.addPreProcessStackDescription(name, condition)
  local theStack = theCoAlg.words[theCoAlg.curWord].preProcess
  theStack[#theStack+1] = { }
  local aDesc = theStack[#theStack]
  aDesc.name = name
  aDesc.condition = condition
end

function coAlgs.addPostProcessStackDescription(condition)
  local theStack = theCoAlg.words[theCoAlg.curWord].postProcess
  theStack[#theStack+1] = { }
  local aDesc = theStack[#theStack]
  aDesc.condition = condition
end

function coAlgs.addJoyLoLCode(bufferName)
  local theCode = theCoAlg.words[theCoAlg.curWord].joyLoLCode
  theCode[#theCode+1] = buffers.getcontent(bufferName)
end

function coAlgs.addCHeader(bufferName)
  local theCode = theCoAlg.words[theCoAlg.curWord].cHeader
  theCode[#theCode+1] = buffers.getcontent(bufferName)
end

function coAlgs.addCCode(bufferName)
  local theCode = theCoAlg.words[theCoAlg.curWord].cCode
  theCode[#theCode+1] = buffers.getcontent(bufferName)
end

function coAlgs.addLuaCode(bufferName)
  local theCode = theCoAlg.words[theCoAlg.curWord].luaCode
  theCode[#theCode+1] = buffers.getcontent(bufferName)
end

coAlgs.joyLoL = joyLoL
