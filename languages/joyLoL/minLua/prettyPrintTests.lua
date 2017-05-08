-- A Lunatests Lua file

local ppt = { }

local pp = require('prettyPrint')

local lt = require('lunatest')
local assert_equal, assert_match = lt.assert_equal, lt.assert_match


function ppt.test_simpleValues()
  assert_equal('"a test string"', pp.toString('a test string'))
  assert_equal('nil', pp.toString(nil))
  assert_equal('true', pp.toString(true))
  assert_equal('false', pp.toString(false))
  assert_equal('12345', pp.toString(12345))
  assert_equal('-12345', pp.toString(-12345))
  assert_equal('0.5', pp.toString(1/2))
  assert_match(
    '^function: 0x[a-fA-F0-9]+$',
    pp.toString(function(a) return a end)
  )
  assert_match(
    '^thread: 0x[a-fA-F0-9]+$',
    pp.toString(coroutine.create(function(a) return a end))
  )
--
-- it is too hard to create a userdata at the moment
-- so we sketch a test...
--  assert_match(
--    '^userdata: 0x[a-fA-F0-9]+$',
--    pp.toString(aUserData)
--  )
end

function ppt.test_simpleArray()
  local simpleArray = { 'one', 'two', 'three' }
  assert_equal(
    '{\n  "one",\n  "two",\n  "three",\n}',
    pp.toString(simpleArray)
  )
end

function ppt.test_simpleHash()
  local simpleHash = { oneKey = 'oneValue', twoKey = 'twoValue' }
  assert_equal(
    '{\n  ["oneKey"] = "oneValue",\n  ["twoKey"] = "twoValue",\n}',
    pp.toString(simpleHash)
  )
end

function ppt.test_mixedTable()
  local mixedTable = {
    'one', 'two', 'three',
    oneKey = 'oneValue', twoKey = 'twoValue'
  }
  assert_equal(
    '{\n  "one",\n  "two",\n  "three",\n  ["oneKey"] = "oneValue",\n  ["twoKey"] = "twoValue",\n}',
    pp.toString(mixedTable)
  )
end

function ppt.test_recursedTable()
  local recursedTable = {
    { 'one', 'two' },
    'three',
    oneKey = { oneKey = "oneValue", twoKey = "twoValue" }
  }
  assert_equal(
    '{\n  {\n    "one",\n    "two",\n  },\n  "three",\n  ["oneKey"] = {\n    ["oneKey"] = "oneValue",\n    ["twoKey"] = "twoValue",\n  },\n}',
    pp.toString(recursedTable)
  )
end

return ppt