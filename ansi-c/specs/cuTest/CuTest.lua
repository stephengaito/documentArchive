-- A Lua file

local cuTest = { }

function cuTest.allTests(testName)
  testName = testName:gsub('^(.)', function(c) return c:upper() end)
  local allTests = { }
  allTests['a'] = 'All'..testName..'Tests'
  allTests['c'] = 'All'..testName..'Tests.c'
  allTests['o'] = 'All'..testName..'Tests.o'
  allTests['s'] = './All'..testName..'Tests'
  return allTests
end

function cuTest.buildAllTests(allTestName, testFiles)
  print('\nCreating ['..allTestName..']')
  
  for i, aTestFile in ipairs(testFiles) do 
    print(aTestFile)
  end
end

function cuTest.buildTestSuites(specsFileName, suiteFileName)
  print('\nFinding tests in: ['..specsFileName..']')
  print('creating: ['..suiteFileName..']')
  
end

return cuTest