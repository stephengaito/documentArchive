-- A Lua Lakefile

local pp = require('pl.pretty')

local tests    =  { }
tests.dir      = './languages/joyLoL/build/tests'
tests.orgDir   = './languages/joyLoL/minLua'

tests.ltScript = tests.dir..'/lunatest.lua'
tests.ltURL    = 'https://github.com/stephengaito/lunatest/raw/master/lunatest.lua'
--
target(tests.ltScript, '', function()
  if not path.isfile(tests.ltScript) then
    os.execute('wget --directory-prefix='..tests.dir..' '..tests.ltURL)
  end
end)

tests.minJoyLoL = tests.dir..'/joyLoL.lua'
tests.orgJoyLoL = tests.orgDir..'/joyLoL.lua'
--
target(tests.minJoyLoL, tests.orgJoyLoL, function(t)
  file.copy(tests.orgJoyLoL, tests.minJoyLoL, true)
end)

tests.minPP = tests.dir..'/prettyPrint.lua'
tests.orgPP = tests.orgDir..'/prettyPrint.lua'
--
target(tests.minPP, tests.orgPP, function(t)
  file.copy(tests.orgPP, tests.minPP, true)
end)

tests.ltTests   = tests.dir..'/allUnitTests'
tests.orgTests  = tests.orgDir..'/joyLoLTests.lua'
--
target(tests.ltTests, tests.orgTests, function()
  file.copy(tests.orgTests, tests.ltTests, true)
end)

tests.ppTests    = tests.dir..'/prettyPrintTests.lua'
tests.orgPPTests = tests.orgDir..'/prettyPrintTests.lua'
--
target(tests.ppTests, tests.orgPPTests, function()
  file.copy(tests.orgPPTests, tests.ppTests, true)
end)

tests.target = target(
  'tests',
  { tests.ltTests, tests.minJoyLoL, tests.ppTests, tests.minPP, tests.ltScript },
  'texlua '..tests.ltTests..' -v'
)

return tests