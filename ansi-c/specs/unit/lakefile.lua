-- A Lua Lakefile

local cuTest = dofile('../cuTest/CuTest.lua')

local joyLoL = target('../../lib/joyLoL.so', '', function(t)
  lfs.chdir('../../lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../specs/unit')
  print('')
  print(lfs.currentdir())
end)

cuTest.program{'allUnitTests', deps={ joyLoL.target }} 

default(target('allUnitTests.test', 'allUnitTests', './allUnitTests'))
