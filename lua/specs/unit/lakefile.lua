-- A Lua LakeFile for joyLoL/lua/specs/unit

-- ensure both 5.2 and 5.3 directories exist
--
lfs.mkdir('5.2') 
lfs.mkdir('5.3')

-- specify how to build the joyLoLC libraries
--
local function lakeLib(aTarget)
  lfs.chdir('../../../ansi-c/lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../../lua/specs/unit')
  print('')
  print(lfs.currentdir())
end

-- determine what is in the joyLoLC libraries
--
local joyLoLSrcs    = path.files_from_mask('../../../ansi-c/lib/*.c', true)
local joyLoLHeaders = path.files_from_mask('../../../ansi-c/lib/*.h', true)
for i=1,#joyLoLHeaders do
  joyLoLSrcs[#joyLoLSrcs+1] = joyLoLHeaders[i]
end

-- specify the joyLoLC library targets
--
local joyLoLC52 = 
  target('../../../ansi-c/lib/5.2/joyLoLC.so', joyLoLSrcs, lakeLib)
local joyLoLC53 = 
  target('../../../ansi-c/lib/5.3/joyLoLC.so', joyLoLSrcs, lakeLib)

-- specify how to build the allUnitTests programs
--
local allTests52 = target(
  '5.2/allUnitTests',
  { path.files_from_mask('*Specs.lua'), joyLoLC52.target},
  '../lunaTest/specs2all.lua $(TARGET) $(DEPENDS)'
)
local allTests53 = target(
  '5.3/allUnitTests',
  { path.files_from_mask('*Specs.lua'), joyLoLC53.target},
  '../lunaTest/specs2all.lua $(TARGET) $(DEPENDS)'
)

-- provide human useful external test targets
--
target('test52', allTests52.target, './5.2/allUnitTests')
target('test53', allTests53.target, './5.3/allUnitTests')
target('testTA', allTests53.target, 'textadept --force --nosession --userhome .')

-- test all versions by default
--
default(target('tests', 'test52 test53 testTA', ''))
