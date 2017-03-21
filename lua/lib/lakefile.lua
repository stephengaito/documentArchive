-- A Lua Lakefile for joyLoL/lua/lib

LUA_LIBS = 'lua5.2'
--LUA_LIBS = 'lua5.3'

--- variables for package joyLoL
JOYLOL_INCLUDE_DIR = '../../ansi-c/lib'
JOYLOL_LIB_DIR     = '../../ansi-c/lib'
JOYLOL_LIBS        = 'joyLoL'
----


local joyLoLshared = c.shared{
  'joyLoL',
  src='*',
 -- incdir='../../ansi-c/lib',
  needs='lua joyLoL'
}

default{joyLoLshared}