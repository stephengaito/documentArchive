# Multiply OS-threaded Lua

## Goal

Explore multiply OS-threaded Lua.

## Tasks

## Questions

**What will the "main" process do while the alternate thread 
is "running"?**

For Lua we can do anything we like.

For Textadept, we can model the interaction on the existing 
textadept.run.compile method.

For LuaTex, this is completely unknown.

**What "wire-protocol" should be used between the independent 
Lua instances (inside the same process)?**
