-- A Lua Lakefile for joyLoL/ansi-c/specs/unit

local cuTest = dofile('../cuTest/CuTestLakeLang.lua')

local joyLoL = target('../../lib/libjoyLoL.a', '', function(t)
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
