# Simple shared library for Lua

## Goal

Show that we can create a simple shared library for lua written in ANSI-C 
which can be used inside lua5.2 and lua5.3, textadept and luaTex/ConTeXt. 

## Tasks 

Create a (linux) shared library using the Lua C-API which returns the string "Hello 
World!". 

## Questions 

### Lua version interoperablity 

Currently LuaTex embeds Lua v5.2 while Textadept embeds Lua 5.3. This 
means that our implementation of a JoyLoL Lua library must be able to 
compile against either Lua version. In particular, we need to carefully 
adhere to the specifications of the ['Incompatibilities with the Previous 
Version' (section 8)](https://www.lua.org/manual/5.3/manual.html#8) of the 
[Lua v5.3 manual](https://www.lua.org/manual/5.3/). 

How do we ensure that the shared library gets compiled for both 
lua5.2/luatex and lua5.3/textadept? 

Where should the resulting shared libraries be placed for each platform? 

