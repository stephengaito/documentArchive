-- A Lua Lakefile for joyLoL/ansi-c/specs/unit

local cuTest = dofile('../cuTest/CuTestLakeLang.lua')

-- ensure both 5.2 and 5.3 directories exist
--
lfs.mkdir('5.2') 
lfs.mkdir('5.3')

-- specify how to build the joyLoLC libraries
--
local function lakeLib(aTarget)
  lfs.chdir('../../lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../specs/unit')
  print('')
  print(lfs.currentdir())
end

-- determine what is in the joyLoLC libraries
--
local joyLoLSrcs    = path.files_from_mask('../../lib/*.c', true)
local joyLoLHeaders = path.files_from_mask('../../lib/*.h', true)
for i=1,#joyLoLHeaders do
  joyLoLSrcs[#joyLoLSrcs+1] = joyLoLHeaders[i]
end


-- specify the joyLoLC library targets
--
local joyLoLC52 = 
  target('../../lib/5.2/joyLoLC.so', joyLoLSrcs, lakeLib)
local joyLoLC53 = 
  target('../../lib/5.3/joyLoLC.so', joyLoLSrcs, lakeLib)

-- specify how to build the allUnitTests programs
--
local allTests52 = cuTest.program{
  '5.2/allUnitTests',
  deps={ joyLoLC52.target },
  odir='5.2',
  needs='lua5.2'
} 
local allTests53 = cuTest.program{
  '5.3/allUnitTests',
  deps={ joyLoLC53.target },
  odir='5.3',
  needs='lua5.3'
} 

-- provide human useful external test targets
--
target('test52', allTests52.target, './5.2/allUnitTests')
target('test53', allTests53.target, './5.3/allUnitTests')

-- test both versions by default
--
default(target('tests', 'test52 test53', ''))
