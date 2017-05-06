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
local table_concat = table.concat

function joyLoL.version()
  return 'JoyLoL minimal Lua version: 0.0.1 (hand coded)'
end

joyLoL.trace = false

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
  if type(strToParse) == 'string' then
    local position = 1
    local whiteSpace = strToParse:match('^%s+', position)
    if whiteSpace then position = position + #whiteSpace end
    local aWord = strToParse:match('^[^%s]+', position)
    if not aWord then aWord = "" end
    position = position + #aWord
    local restOfStrToParse = strToParse:sub(position, #strToParse)
    pushData(aCtx, restOfStrToParse)
    pushData(aCtx, aWord)
  else
    pushData(aCtx, "")
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
  if type(aWord) == 'string' and 0 < #aWord then
    local aList = popProcess(aCtx)
    local closingChar = peekProcess(aCtx)
    if aWord == closingChar then
      -- pop up one level of parseList recursion...
      popProcess(aCtx)       -- remove this closing char
      local prevList = popProcess(aCtx)
      table_insert(prevList, aList)
      pushProcess(aCtx, prevList)
      pushProcess(aCtx, 'parseList')
      pushProcess(aCtx, 'nextWord')
    elseif matchingSymbols[aWord] then
      -- push down one level of parseList recursion...
      pushProcess(aCtx, aList) -- replace aList back on to stack
      pushProcess(aCtx, matchingSymbols[aWord]) -- recursive list end
      pushProcess(aCtx, {})                     -- recursive list to build
      pushProcess(aCtx, 'parseList')
      pushProcess(aCtx, 'nextWord')
    else
      -- add word to list and continue parsing list
      table_insert(aList, aWord)
      pushProcess(aCtx, aList)
      pushProcess(aCtx, 'parseList')
      pushProcess(aCtx, 'nextWord')
    end
  else
    popData(aCtx) -- remove the empty rest of string
    local aList = popProcess(aCtx)
    pushData(aCtx, aList)
    popProcess(aCtx) -- remove the matching symbol
  end
end

local parseList = joyLoL.parseList

function joyLoL.parse(aCtx)
  pushProcess(aCtx, "")  -- closingChar
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
  
  if prevJoyLoLChunk
    and type(prevJoyLoLChunk) == 'string'
    and 0 < #prevJoyLoLChunk then
    table_insert(renderedText, prevJoyLoLChunk)
  end
  
  if type(curTemplate) == 'string' and (0 < #curTemplate) then
    if curTemplate:find('{{') then
      local position  = 1
      local textChunk = curTemplate:match('^.*{{', position)
      if textChunk then 
        local textChunkLen = #textChunk
        textChunk = textChunk:sub(1, textChunkLen-2)
        if 0 < #textChunk then table_insert(renderedText, textChunk) end
        position = position + textChunkLen
      end
      
      local joyLoLChunk = curTemplate:match('^.+}}', position)
      if joyLoLChunk then
        local joyLoLChunkLen = #joyLoLChunk
        joyLoLChunk = joyLoLChunk:sub(1, joyLoLChunkLen-2)
        position = position + joyLoLChunkLen
        curTemplate = curTemplate:sub(position, #curTemplate)
        pushProcess(aCtx, curTemplate)
        pushProcess(aCtx, renderedText)
        pushProcess(aCtx, 'renderNextChunk')
        if not joyLoLChunk:match('^%s*$') then
          pushProcess(aCtx, 'eval')
          pushProcess(aCtx, 'parse')
          pushData(aCtx, joyLoLChunk)
        else
          pushData(aCtx, "")
        end
      end
    else -- there is no '{{' in the template
      table_insert(renderedText, curTemplate)
      pushData(aCtx, table_concat(renderedText))
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
    if joyLoL.trace then
      print('\n\n-----')
      print(pp.write(aCtx))
    end
    local aCmd = popProcess(aCtx)
    if type(aCmd) == 'function' then
      if joyLoL.trace then print('calling: ['..pp.write(aCmd)..']') end
      aCmd(aCtx)
    elseif type(joyLoL[aCmd]) == 'function' then
      if joyLoL.trace then print('calling: ['..aCmd..']('..pp.write(joyLoL[aCmd])..')') end
      joyLoL[aCmd](aCtx)
    else
      if joyLoL.trace then print('adding: ['..pp.write(aCmd)..']') end
      pushData(aCtx, aCmd)
    end
  end
  if joyLoL.trace then print('finished eval: ['..pp.write(aCtx.data)..']') end
  return aCtx.data
end

local evalCtx = joyLoL.eval

function joyLoL.evalString(aStr)
  local aCtx = newContext()
  pushProcess(aCtx, "eval")
  pushProcess(aCtx, "parse")
  pushData(aCtx, aStr)
  return evalCtx(aCtx)
end


return joyLoL