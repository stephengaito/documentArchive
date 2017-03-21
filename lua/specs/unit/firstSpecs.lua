-- A LunaTest specification file

-- This is our first set of tests
-- We expect the "helloWorld" methods in the Lua-C interface to work

local lt = dofile('../lunaTest/lunatest.lua')

local firstSpecs = { }

function firstSpecs.test_first()
  lt.assert_equal(helloWorld(), 'Hello world!')
end

function firstSpecs.test_second()
  lt.assert_equal(helloWorld('Chris'), 'Hello Chris!')
end

return firstSpecs