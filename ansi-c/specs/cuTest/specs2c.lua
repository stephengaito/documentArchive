#!/usr/bin/env lua 

-- This Lua Script reads a *.specs file and creates the associated *.c 
-- CuTest file 

local pp = require 'pl.pretty'

if #arg < 1 then
  print('usage: '..arg[0]..' <specsFile>')
  os.exit(-1)
end

local specsFileName = arg[1]
if not specsFileName:match('%.specs$') then
  print("your specs file must have the extension '.specs'!")
  os.exit(-2)
end

local cFileName = specsFileName:gsub('%.specs$', '.c')

print('\nFinding tests in: ['..specsFileName..']')
print('creating: ['..cFileName..']')

local tests = { }
local suiteName = specsFileName:gsub('%.specs$', '')

local specsFile = io.open(specsFileName, 'r')
if not specsFile then
  print('Could not read from ['..specsFileName..']\n')
  os.exit(-3)
end

local cFile     = io.open(cFileName, 'w')
if not cFile then
  print('Could not write to ['..cFileName..']\n')
  os.exit(-4)
end

for aLine in specsFile:lines() do 
  if aLine:match('^void Test') then
    tests[#tests+1] = aLine:gsub('%(.*$',''):gsub('^void%s+','')
  end
  
  if aLine:match('^%/%/%s+suiteName:') then
    suiteName = aLine:gsub('^%/%/%s+suiteName:%s+','')
  end
  
  cFile:write(aLine)
  cFile:write('\n')
end

specsFile:close()

local specName = specsFileName:gsub('%.specs$','')

cFile:write('\n')

cFile:write('CuSuite* ')
cFile:write(specName)
cFile:write('GetSuite(void) {\n')

cFile:write('\n')

cFile:write('  CuSuite* suite = CuSuiteNew("')
cFile:write(suiteName)
cFile:write('", (void*)0);\n')

cFile:write('\n')

for i, aTestName in ipairs(tests) do
  cFile:write('  SUITE_ADD_TEST(suite, ')
  cFile:write(aTestName)
  cFile:write(');\n')
end

cFile:write('\n')

cFile:write('  return suite;\n')

cFile:write('}\n')

cFile:close()