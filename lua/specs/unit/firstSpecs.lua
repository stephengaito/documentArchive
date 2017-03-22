-- A LunaTest specification file

-- This is our first set of tests
-- We expect the "helloWorld" methods in the Lua-C interface to work

local joyLoL = require 'joyLoLC'

local lt = lunaTest

local firstSpecs = { }

function firstSpecs.test_first()
  lt.assert_equal(joyLoL.helloWorld(''), 'Hello world!\n')
end

function firstSpecs.test_second()
  lt.assert_equal(joyLoL.helloWorld('Chris'), 'Hello Chris!\n')
end

return firstSpecs