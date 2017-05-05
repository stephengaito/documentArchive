-- A Lua Lakefile

local pp = require('pl.pretty')

local tests =  { }
tests.dir       = './languages/joyLoL/build/tests'
tests.orgDir    = './languages/joyLoL/minLua'

tests.ltScript  = tests.dir..'/lunatest.lua'
tests.ltURL     = 'https://github.com/stephengaito/lunatest/raw/master/lunatest.lua'

tests.minJoyLoL = tests.dir..'/joyLoL.lua'
tests.orgJoyLoL = tests.orgDir..'/joyLoL.lua'

tests.ltTests   = tests.dir..'/allUnitTests'
tests.orgTests  = tests.orgDir..'/joyLoL.tests'

target(tests.ltScript, '', function()
  if not path.isfile(tests.ltScript) then
    os.execute('wget --directory-prefix='..tests.dir..' '..tests.ltURL)
  end
end)

target(tests.minJoyLoL, tests.orgJoyLoL, function(t)
  file.copy(tests.orgJoyLoL, tests.minJoyLoL, true)
end)

target(tests.ltTests, tests.orgTests, function()
  file.copy(tests.orgTests, tests.ltTests, true)
end)

return target(
  'tests',
  { tests.ltTests, tests.minJoyLoL, tests.ltScript },
  'texlua '..tests.ltTests..' -v'
)