-- A Lua Lakefile for joyLoL/ansi-c/specs/unit

local cuTest = dofile('../cuTest/CuTestLakeLang.lua')
local lfs    = require 'lfs'
--local pp     = require 'pl.pretty'

local function lakeLib(aTarget)
  lfs.chdir('../../lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../specs/unit')
  print('')
  print(lfs.currentdir())
end

local joyLoLSrcs = path.files_from_mask('../../lib/*.c')

local joyLoL = target('../../lib/5.2/joyLoLC.so', joyLoLSrcs, lakeLib(t))

cuTest.program{'allUnitTests', deps={ joyLoL.target }} 

default(target('allUnitTests.test', 'allUnitTests', './allUnitTests'))
