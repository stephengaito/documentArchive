-- A Lua Lakefile

local cuTest = dofile('../cuTest/CuTest.lua')

-- local libJoyLoL = '../../lib/libJoyLoL.so'
-- objFiles[#objFiles+1] = libJoyLoL

cuTest.program{'allUnitTests'}

default(target('allUnitTests.test', 'allUnitTests', './allUnitTests'))
