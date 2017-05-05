-- A Lua file

-- Copyright (C) 2017 PerceptiSys Ltd (Stephen Gaito)
--
-- Permission is hereby granted, free of charge, to any person obtaining a 
-- copy of this software and associated documentation files (the 
-- "Software"), to deal in the Software without restriction, including 
-- without limitation the rights to use, copy, modify, merge, publish, 
-- distribute, sublicense, and/or sell copies of the Software, and to 
-- permit persons to whom the Software is furnished to do so, subject to 
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included 
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

local pp = require('pl.pretty')

local joyLoL = { }
local table_insert = table.insert
local table_remove = table.remove
local table_append = table.append
local table_concat = table.concat

function joyLoL.version()
  return 'JoyLoL minimal Lua version: 0.0.1 (hand coded)'
end

-- We need JoyLoL contexts

function joyLoL.newContext()
  return { data = { }; process = { } }
end

local newContext = joyLoL.newContext

function joyLoL.pushData(aCtx, anObj)
  return table_insert(aCtx.data, 1, anObj)
end

local pushData = joyLoL.pushData

function joyLoL.popData(aCtx)
  local result = nil
  if 0 < #aCtx.data then
    result = table_remove(aCtx.data, 1)
  end
  return result
end

local popData = joyLoL.popData

function joyLoL.peekData(aCtx)
  local result = nil
  if 0 < #aCtx.data then
    result = aCtx.data[1]
  end
  return result
end

local peekData = joyLoL.peekData

function joyLoL.pushProcess(aCtx, anObj)
  return table_insert(aCtx.process, 1, anObj)
end

local pushProcess = joyLoL.pushProcess

function joyLoL.popProcess(aCtx)
  local result = nil
  if 0 < #aCtx.process then
    result = table_remove(aCtx.process, 1)
  end
  return result
end

local popProcess = joyLoL.popProcess

function joyLoL.peekProcess(aCtx)
  local result = nil
  if 0 < #aCtx.process then
    result = aCtx.process[1]
  end
  return result
end

local peekProcess = joyLoL.peekProcess


-- We need a JoyLoL LPeg parser which is capable of parsing a simple Lua 
-- string 

function joyLoL.nextWord(aCtx)
  local strToParse = popData(aCtx)
  print(type(strToParse))
  if type(strToParse) == 'string' then
    local position = 1
    local whiteSpace = strToParse:match('%s+', position)
    if whiteSpace then position = position + #whiteSpace end
    local aWord = strToParse:match('[^%s]+', position)
    position = position + #aWord
    local restOfStrToParse = strToParse:sub(position, #strToParse-position)
    print(pp.write(restOfStrToParse))
    pushData(aCtx, restOfStrToParse)
    pushData(aCtx, aWord)
  else
    pushData(aCtx, strToParse)
    pushData(aCtx, "")
  end
end

local nextWord = joyLoL.nextWord

local matchingSymbols = {
  ['('] = ')';
  ['{'] = '}';
  ['<'] = '>';
  ['['] = ']'
}

function joyLoL.parseList(aCtx)
  local aWord = popData(aCtx)
  if aWord then
    local aList = popProcess(aCtx)
    local closingChar = peekProcess(aCtx)
    if aWord == closingChar then
      popProcess(aCtx)       -- we are finished parsing
      popData(aCtx)          -- remove the rest of the string
      pushData(aCtx, aList)  -- place result on data
    elseif matchingSymbols[aWord] then
      pushProcess(aCtx, matchingSymbols[aWord]) -- recursive list end
      pushProcess(aCtx, {})                     -- recursive list to build
      pushProcess(aCtx, 'parseList')
      pushProcess(aCtx, 'nextWord')
    elseif aWord then
      if not aList then aList = { } end
      table_append(aList, aWord)
      pushProcess(aCtx, aList)       -- continue parsing list
      pushProcess(aCtx, 'parseList')
      pushProcess(aCtx, 'nextWord')
    else -- ERROR!
      -- do something!
    end
  end
end

local parseList = joyLoL.parseList

function joyLoL.parse(aCtx)
  pushProcess(aCtx, 0)  -- closingChar
  pushProcess(aCtx, {}) -- list being built
  pushProcess(aCtx, 'parseList')
  pushProcess(aCtx, 'nextWord')
end

local parseJoyLoL = joyLoL.parse

-- We need a simple JoyLoL template engine
-- Our template engine has been inspired by:
--   https://john.nachtimwald.com/2014/08/06/using-lua-as-a-templating-engine/

function joyLoL.renderNextChunk(aCtx)
  local renderedText    = popProcess(aCtx)
  local curTemplate     = popProcess(aCtx)
  local prevJoyLoLChunk = popData(aCtx)
  
  if prevJoyLoLChunk then
    table_insert(renderedText, prevJoyLoLChunk)
  end
  
  if type(curTemplate) == 'string' and (0 < #curTemplate) then
    local position  = 1
    local textChunk = curTemplate:match('.+{{', position)
    if textChunk then 
      local textChunkLen = #textChunk
      textChunk = textChunk:sub(position, textChunkLen-2)
      table_insert(renderedText, textChunk)
      position = position + textChunkLen
    end
    
    local joyLoLChunk = curTemplate:match('.+}}', position)
    if joyLoLChunk then
      local joyLoLChunkLen = #joyLoLChunk
      joyLoLChunk = joyLoLChunk:sub(position, joyLoLChunkLen-2)
      position = position + joyLoLChunkLen
      curTemplate = curTemplate:sub(position, #curTemplate-position)
      pushProcess(aCtx, curTemplate)
      pushProcess(aCtx, renderedText)
      pushProcess(aCtx, 'renderNextChunk')
      pushProcess(aCtx, 'eval')
      pushProcess(aCtx, 'parse')
      pushData(aCtx, joyLoLChunk)
    end
  else
    -- nothing more to do...
    pushData(table_concat(renderedText))
  end
end

local renderChunk = joyLoL.renderChunk

function joyLoL.render(aCtx)
  local aTemplate = popData(aCtx)
  pushData(aCtx, {})    -- "result" of "initial" joyLoLChunk

  pushProcess(aCtx, aTemplate)
  pushProcess(aCtx, {}) -- result of renderer
  pushProcess(aCtx, 'renderNextChunk')
end

local render = joyLoL.render

-- We need to be able to evaluate contexts.

function joyLoL.eval(aCtx)
  while 0 < #aCtx.process do
    print('\n\n-----')
    print(pp.write(aCtx))
    local aCmd = popProcess(aCtx)
    if type(aCmd) == 'function' then
      aCmd(aCtx)
    elseif type(joyLoL[aCmd]) == 'function' then
      print('calling: ['..aCmd..']')
      joyLoL[aCmd](aCtx)
    else
      pushData(aCmd)
    end
  end
  return aCtx.data
end

local evalCtx = joyLoL.eval

function joyLoL.evalString(aStr)
  local aCtx = newContext()
  pushProcess(aCtx, "eval")
  pushProcess(aCtx, "parse")
  pushData(aCtx, aStr)
  evalCtx(aCtx)
end


return joyLoL