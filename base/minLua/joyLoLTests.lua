-- A Lunatest Lua file

local pp     = require('pl.pretty')

package.path = './languages/joyLoL/buildDir/tests/?.lua;'..package.path

local lt            = require('lunatest')
local assert_equal  = lt.assert_equal
local assert_table  = lt.assert_table
local assert_nil    = lt.assert_nil
local assert_string = lt.assert_string
local assert_match  = lt.assert_match

local joyLoL = require('joyLoL')
local pushData, peekData, peekNData, popData
  = joyLoL.pushData, joyLoL.peekData, joyLoL.peekNData, joyLoL.popData
local pushProcess, peekProcess, peekNProcess, popProcess
  = joyLoL.pushProcess, joyLoL.peekProcess, joyLoL.peekNProcess, joyLoL.popProcess
local pushProcessQuoted = joyLoL.pushProcessQuoted
local newContext = joyLoL.newContext
local jEval = joyLoL.eval

lt.suite('prettyPrintTests')

function test_nextWord()
  --
  -- If we parse a string then the first word is on top
  -- and the rest of the string is below
  --
  local aCtx = newContext()
  pushData(aCtx, "test")
  joyLoL.nextWord(aCtx)
  assert_equal('test', aCtx.data[1])
  assert_equal('',     aCtx.data[2])
  --
  aCtx = newContext()
  pushData(aCtx, "this is a test  ")
  joyLoL.nextWord(aCtx)
  assert_equal('this',       popData(aCtx))
  assert_equal(' is a test  ', joyLoL.peekData(aCtx))
  joyLoL.nextWord(aCtx)
  assert_equal('is',       popData(aCtx))
  assert_equal(' a test  ', joyLoL.peekData(aCtx))
  joyLoL.nextWord(aCtx)
  assert_equal('a',       popData(aCtx))
  assert_equal(' test  ', joyLoL.peekData(aCtx))
  joyLoL.nextWord(aCtx)
  assert_equal('test',       popData(aCtx))
  assert_equal('  ', joyLoL.peekData(aCtx))
  joyLoL.nextWord(aCtx)
  assert_equal('',       popData(aCtx))
  assert_equal('', joyLoL.peekData(aCtx))
  --
  -- If we attempt to parse something that is not a string
  -- then delete it and place two empty strings on the stack
  aCtx = newContext()
  pushData(aCtx, {})
  joyLoL.nextWord(aCtx)
  assert_equal('',       popData(aCtx))
  assert_equal('', joyLoL.peekData(aCtx))
end

function test_parse()
  --
  -- parse a string into a list structure
  -- when we are done the list replaces the original string 
  --
  local aCtx = newContext()
  pushData(aCtx, " this is a test ")
  pushProcess(aCtx, "parse")
  jEval(aCtx)
  assert_nil(popProcess(aCtx))
  local aList = popData(aCtx)
  assert_table(aList)
  assert_equal(4, #aList)
  assert_equal("this", aList[1])
  assert_equal("is",   aList[2])
  assert_equal("a",    aList[3])
  assert_equal("test", aList[4])
  --
  aCtx = newContext()
  pushData(aCtx, " this ( is a ) test ")
  pushProcess(aCtx, "parse")
  jEval(aCtx)
  assert_nil(popProcess(aCtx))
  local aList = popData(aCtx)
  assert_table(aList)
  assert_equal(3, #aList)
  assert_equal("this", aList[1])
  assert_equal("test", aList[3])
  local innerList = aList[2]
  assert_table(innerList)
  assert_equal(2, #innerList)
  assert_equal('is', innerList[1])
  assert_equal('a',  innerList[2])
end

function test_renderNextChunk()
  --
  -- show that we can extract the 'next chunk' from a template
  --
  local aCtx = newContext()
  pushData(aCtx, "")
  pushProcess(aCtx, " this is a {{ test block }} this is the rest ")
  pushProcess(aCtx, {})
  joyLoL.renderNextChunk(aCtx)
  assert_equal(" test block ", popData(aCtx))
  assert_equal('parse', popProcess(aCtx))
  assert_equal('interpret', popProcess(aCtx))
  assert_equal('renderNextChunk', popProcess(aCtx))
  local aList = popProcess(aCtx)
  assert_table(aList)
  assert_equal(1, #aList)
  assert_equal(" this is a ", aList[1])
  assert_equal(" this is the rest ", popProcess(aCtx))
  --
  aCtx = newContext()
  pushData(aCtx, "")
  pushProcess(aCtx, " this is a test with no joyLoL block ")
  pushProcess(aCtx,{})
  joyLoL.renderNextChunk(aCtx)
  assert_equal(" this is a test with no joyLoL block ", popData(aCtx))
  assert_table(aCtx.process)
  assert_equal(0, #aCtx.process)
  --
  aCtx = newContext()
  pushData(aCtx, "")
  pushProcess(aCtx, "{{ this is a test with no non-joyLoL block }}")
  pushProcess(aCtx,{})
  joyLoL.renderNextChunk(aCtx)
  assert_equal(" this is a test with no non-joyLoL block ", popData(aCtx))
  assert_equal('parse', popProcess(aCtx))
  assert_equal('interpret', popProcess(aCtx))
  assert_equal('renderNextChunk', popProcess(aCtx))
  local aList = popProcess(aCtx)
  assert_table(aList)
  assert_equal(0, #aList)
  assert_equal("", popProcess(aCtx))
  --
  aCtx = newContext()
  pushData(aCtx, "")
  pushProcess(aCtx, "this is a test {{ }} with an essentially empty joyLoL block")
  pushProcess(aCtx,{})
  joyLoL.renderNextChunk(aCtx)
  assert_equal("", popData(aCtx))
  assert_equal('renderNextChunk', popProcess(aCtx))
  local aList = popProcess(aCtx)
  assert_table(aList)
  assert_equal(1, #aList)
  assert_equal("this is a test ", aList[1])
  assert_equal(" with an essentially empty joyLoL block", popProcess(aCtx))
end

function test_render()
  --
  -- show that we can render a full template
  --
  local aCtx = newContext()
  pushData(aCtx, " > this is a test {{   }} with no joyLoL block < ")
  pushProcess(aCtx, "render")
  jEval(aCtx)
  assert_table(aCtx.process)
  assert_equal(0, #aCtx.process)
  assert_equal(" > this is a test  with no joyLoL block < ", popData(aCtx))
  --
  pushData(aCtx, " > this is a test {{ reportContext }} with simple joyLoL block < ")
  pushProcess(aCtx, "render")
  jEval(aCtx)
  assert_table(aCtx.process)
  assert_equal(0, #aCtx.process)
  local renderedText = popData(aCtx)
  --print('>>'..renderedText..'<<')
  assert_match("^ > this is a test", renderedText)
  assert_match(" with simple joyLoL block < $", renderedText)
  assert_match('%[%"data%"%] %=', renderedText)
  assert_match('%[%"process%"%] %=', renderedText)
  --
  aCtx = newContext()
  pushProcess(aCtx, 'render')
  pushProcessQuoted(aCtx, " > this is a test {{ lookupInDict 'aKey }} with complex joyLoL block < ")  
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, 'aValue')
  pushProcessQuoted(aCtx, 'aKey')
  joyLoL.newDictionary(aCtx)
  jEval(aCtx)
  assert_table(aCtx.process)
  assert_equal(0, #aCtx.process)
  assert_equal(" > this is a test aValue with complex joyLoL block < ", popData(aCtx))
end

function test_lists()
  --
  -- test manipulation of lists
  --
  local aCtx = newContext()
  pushProcess(aCtx, 'pushOntoList')
  pushProcess(aCtx, 'item2')
  joyLoL.newList(aCtx)
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  local aList = peekData(aCtx)
  assert_table(aList)
  assert_equal(1, #aList)
  assert_equal('item2', aList[1])
  pushProcess(aCtx, 'pushOntoList')
  pushProcess(aCtx, 'item1')
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  aList = peekData(aCtx)
  assert_table(aList)
  assert_equal(2, #aList)
  assert_equal('item1', aList[1])
  assert_equal('item2', aList[2])
  pushProcess(aCtx, 'popFromList')
  jEval(aCtx)
  assert_equal(2, #aCtx.data)
  assert_equal('item1', peekNData(aCtx, 1))
  aList = peekNData(aCtx, 2)
  assert_table(aList)
  assert_equal(1, #aList)
  assert_equal('item2', aList[1])
  pushProcess(aCtx, 'appendToEndList')
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  aList = peekData(aCtx)
  assert_table(aList)
  assert_equal(2, #aList)
  assert_equal('item2', aList[1])
  assert_equal('item1', aList[2])
  pushProcess(aCtx, 'removeFromEndList')
  jEval(aCtx)
  assert_equal(2, #aCtx.data)
  assert_equal('item1', peekNData(aCtx, 1))
  aList = peekNData(aCtx, 2)
  assert_table(aList)
  assert_equal(1, #aList)
  assert_equal('item2', aList[1])
  pushProcess(aCtx, 'pushOntoList')
  jEval(aCtx)
  pushProcess(aCtx, 'concatList')
  pushProcess(aCtx, '-')
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  assert_equal('item1-item2', peekData(aCtx))
end

function test_dictionary()
  --
  -- test manipulation of dictionaries
  --
  local aCtx = newContext()
  pushProcess(aCtx, 'addToDict')
  pushProcess(aCtx, 'aValue')
  pushProcess(aCtx, 'aKey')
  joyLoL.newDictionary(aCtx)
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  local aDict = peekData(aCtx)
  assert_table(aDict)
  assert_equal('aValue', aDict['aKey'])
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'aKey')
  jEval(aCtx)
  assert_equal(2, #aCtx.data)
  assert_equal('aValue', popData(aCtx))
  assert_table(peekData(aCtx))
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'notAKey')
  jEval(aCtx)
  assert_equal(2, #aCtx.data)
  assert_equal('', popData(aCtx))
  assert_table(peekData(aCtx))
  pushProcess(aCtx, 'deleteFromDict')
  pushProcess(aCtx, 'aKey')
  jEval(aCtx)
  assert_equal(1, #aCtx.data)
  local aDict = peekData(aCtx)
  assert_table(aDict)
  assert_nil(aDict['aKey'])
end

function test_reportContext()
  local aCtx = newContext()
  pushData(aCtx, 'someThingData')
  pushProcess(aCtx, 'someThingProcess')
  joyLoL.reportContext(aCtx)
  local aCtxStr = popData(aCtx)
  assert_string(aCtxStr)
  assert_match('%[%"data%"%] %= ', aCtxStr)
  assert_match('someThingData', aCtxStr)
  assert_match('%[%"process%"%] %=', aCtxStr)
  assert_match('someThingProcess', aCtxStr)
  --print(aCtxStr)
end

function off_test_evalString()
  print(pp.write(jEvalString('test')))
end

function off_test_fail()
  lt.fail("this should fail")
end



lt.run()
