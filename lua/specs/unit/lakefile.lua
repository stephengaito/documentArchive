-- A Lua LakeFile for joyLoL/lua/specs/unit

local joyLoLC = target('../../lib/joyLoLC.so', '', function(t)
  lfs.chdir('../../../ansi-c/lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../../lua/specs/unit')
  print('')
  print(lfs.currentdir())
end)

target(
  'allUnitTests',
  { path.files_from_mask('*Specs.lua'), joyLoLC.target},
  '../lunaTest/specs2all.lua $(TARGET) $(DEPENDS)'
)

default(target('allUnitTests.test', 'allUnitTests', './allUnitTests --verbose'))