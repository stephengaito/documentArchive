#!/usr/bin/env lua 

-- This Lua Script takes as arguments:
--  <allTestsFileName>
--  <specFileCName>+
-- and creates the associated *<allTestsFileName>.c CuTest file 

local pp = require 'pl.pretty'

if #arg < 2 then
  print('usage: '..arg[0]..' <allTestsFileName> <specFileCName>+')
  os.exit(-1)
end

local allTestsFileName = table.remove(arg, 1)
if not allTestsFileName:match('%.c$') then
  print("your allTests file must have the extension '.c'!")
  os.exit(-2)
end

local allTestsName = allTestsFileName:gsub('%..*$','')

print('\nCreating: ['..allTestsFileName..']')
print('from:')
local getSuites = { }
for i, aFileName in ipairs(arg) do
  print('\t['..aFileName..']')
  getSuites[#getSuites+1] = aFileName:gsub('%..*$', 'GetSuite')
end

local cFile = io.open(allTestsFileName, 'w')
if not cFile then
  print('Could not write to ['..allTestsFileName..']\n')
  os.exit(-3)
end

cFile:write([=[
#include <stdio.h>
#include "CuTest.h"

#define FALSE	0
#define TRUE	1

]=])

for i, aGetSuite in ipairs(getSuites) do
  cFile:write('extern CuSuite* ')
  cFile:write(aGetSuite)
  cFile:write('(void);\n')
end

cFile:write([=[

void RunAllTests(size_t trace) {

  CuString *output = CuStringNew();
  CuSuite* suite = CuSuiteNew("]=])
cFile:write(allTestsName)
cFile:write([=[", (void*)0);

]=])

for i, aGetSuite in ipairs(getSuites) do
  cFile:write('  CuSuiteAddSubSuite(suite, ')
  cFile:write(aGetSuite)
  cFile:write('() );\n')
end

cFile:write([=[

  CuSuiteRun(suite, trace);
  CuSuiteSummary(suite, output);
  CuSuiteDetails(suite, output);
  printf("%s\n", output->buffer);
  CuStringDelete(output);
  CuSuiteDelete(suite);
}

int main(void) {
  RunAllTests(TRUE);
}

]=])


cFile:close()