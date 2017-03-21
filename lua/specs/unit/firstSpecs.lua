-- A LunaTest specification file

-- This is our first set of tests
-- We expect the "helloWorld" methods in the Lua-C interface to work

package.cpath = '../../lib/?.so;'..package.cpath

local joyLoL = require 'joyLoL'

local lt = dofile('../lunaTest/lunatest.lua')

local firstSpecs = { }

function firstSpecs.test_first()
  lt.assert_equal(joyLoL.helloWorld(), 'Hello world!')
end

function firstSpecs.test_second()
  lt.assert_equal(joyLoL.helloWorld('Chris'), 'Hello Chris!')
end

return firstSpecs