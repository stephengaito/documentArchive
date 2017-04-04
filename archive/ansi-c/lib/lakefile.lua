-- A Lua Lakefile for joyLoL/ansi-c/lib

-- ensure both 5.2 and 5.3 directories exist
--
lfs.mkdir('5.2') 
lfs.mkdir('5.3')

-- define what to do for both lua5.2 and lua5.3
--
local joyLoLC52 =
  c.shared{'5.2/joyLoLC', src='*', odir='5.2', needs='lua5.2'}
local joyLoLC53 =
  c.shared{'5.3/joyLoLC', src='*', odir='5.3', needs='lua5.3'}

-- provide human useful external targets
--
target('52', joyLoLC52.target, '')
target('53', joyLoLC53.target, '')

-- build both versions by default
--
default(target('all', '52 53', ''))
