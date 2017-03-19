-- A Lua Lakefile

local cuTest = dofile '../cuTest/CuTest.lua'

local allTests = cuTest.allTests('Unit')
local libJoyLoL = '../../lib/libJoyLoL.so'

local defaultTarget = target(allTests['a'],  )