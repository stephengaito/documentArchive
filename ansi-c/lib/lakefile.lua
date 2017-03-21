-- A Lua Lakefile for joyLoL/ansi-c/lib

LUA_LIBS = 'lua5.2'
--LUA_LIBS = 'lua5.3'

local joyLoLShared = c.shared{'joyLoLC', src='*', needs='lua'}

default{joyLoLShared}
