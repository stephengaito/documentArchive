-- A Lua Lakefile

local cuTest = dofile '../cuTest/CuTest.lua'
local lfs = require 'lfs'
local pp = require 'pl.pretty'

local allTests = cuTest.allTests('Unit')
local libJoyLoL = '../../lib/libJoyLoL.so'

local specFiles = { }
local objFiles = { }
for aFile in lfs.dir('.') do
  if aFile and aFile:match('%.specs$') then
    specFiles[#specFiles+1] = aFile
    objFiles[#objFiles+1]   = aFile:gsub('%.specs$', '-suite.o')
  end
end
print(pp.write(specFiles))
objFiles[#objFiles+1] = '../cuTest/CuTest.o'
objFiles[#objFiles+1] = libJoyLoL
objFiles[#objFiles+1] = allTests['o']
print(pp.write(objFiles))

rule('.suite', '.specs', function(r)
  print(pp.write(r))
end)

rule('.o', '.suite', function(r)
  print(pp.write(r))
end)

local defaultTarget = c.program{allTests['a'], src='*.specs', needs='cuTest joyLoL' }