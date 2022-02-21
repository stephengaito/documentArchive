# Simple shared library for Lua

## Goal

Show that we can create a simple shared library for lua written in ANSI-C 
which can be used inside lua5.2 and lua5.3, textadept and luaTex/ConTeXt. 

## Tasks ![needsWork](/design/images/needsWork.png)

### Install lua build system ![done](/design/images/done.png)

[lake](http://stevedonovan.github.io/lake/scripts/lake.html) 
([gitHub](https://github.com/stevedonovan/Lake)) looks like it has the 
simplest installation, simplest "makefile" for our needs, and best/useful 
documentation. 

> cd /usr/local/bin

> wget https://github.com/stevedonovan/Lake/raw/master/lake

> chmod a+x lake

### Install Test systems ![needsWork](/design/images/needsWork.png)

![done](/design/images/done.png) **CuTest** is simple and best to use for 
raw C code. Old JoyLoL embedded the whole source from 
[cutest](https://github.com/asimjalis/cutest) as forked and modified in 
[stephengaito/cutest](https://github.com/stephengaito/cutest) (using the 
notEqualsAssertions and namedSubSuites branches). This source was located 
in the specs/cuTest directory (which was parallel to the unit, functional, 
and integration directories of test suites). 

![needsWork](/design/images/needsWork.png) **LunaTest** is simple and best 
to use for Lua code. Should be located in a specs/lunaTest directory and 
should be taken from 
[silentbicycle/lunatest](https://github.com/silentbicycle/lunatest) as 
modified by [stephengaito/lunatest]() (See 
[stephengaito/ConTests](https://github.com/stephengaito/ConTests)). As in 
ConTests, we really ONLY need the lunatest.lua file itself, and we really 
only need to be able to 'require' lunatest.lua. 

* ![needsWork](/design/images/needsWork.png) We still need to reconcile 
lunatest.lua currently installed in lua/specs/lunaTest with that used by 
ConTests. 

![notStarted](/design/images/notStarted.png) **ConTests** is a ConTeXt 
module designed to provide tests of ConTeXt-MKiv and Lua methosd inside 
ConTeXt. 

### Obtain lua5.2 and lua5.3 headers ![done](/design/images/done.png)

**Note** Lua5.2 headers/sources should be compatible with LuaTex and Lua5.3 
header/sources should be compatible with Textadept 

- require lua5.2-dev and lua5.3-dev and use "include <lua5.2/lua.h>" or 
  "include <lua5.3/lua.h>" 
- lua.h contains the lua_ definitions
- luaxlib.h contains the luaL_ defintions
- lualib.h contains the definitions to load a particular standard library
- see "C Modules", section 27.3 of "Programming in Lua 3rd Ed"

Could use the unpacked sources contained in both textadept and luatex.

For textadept, these sources are contained in the standard download zip file

* textadept currently (as of March 2017) uses lua 5.3.4

For luatex, these sources are contained in the luatex source tree. However 
only luatex 0.95.0 has a "simple" zip file. To use luatex 1.0.3 you 
(currently) need to use svn to obtain a copy of the subversion controlled 
sources. 
 
* luatex both version 0.95.0 and 1.0.3 currently (as of March 2017) uses 
  lua 5.2.3 

* luatex applies three patches (no changes to these patches between 0.95.0 
  and 1.0.3) 

In both cases, textadept and luatex only really need the header files 
which should (hopefully be stable for all 5.2.x and 5.3.x versions 
respectively) SO we may be able simply to use [lua's source 
zips](http://www.lua.org/ftp/) directly (or of course any related OS 
packages). 

### Create a (linux) shared library ![done](/design/images/done.png)
... using the Lua C-API which returns the string "Hello World!". 

See "C Modules" section 27.3 in "Programming in Lua 3rd Ed".

### Ensure both C and Lua modules have versions ![done](/design/images/done.png)

Provide both explicit and implicit (git-hooks) version information to both 
the C and Lua modules. 

### Install shared libraries ![needsWork](/design/images/needsWork.png)

**Lua** should be located in the /usr/local/lib/lua/5.x directory.

**Textadept** should be located in the ~/.textadept/modules/joylol 
directory.

**LuaTeX** should be located in the 
~/texmf/t-joylol/tex/context/third/joylol directory ... *but* the 
CLUAINPUTS texmf variable MUST be updated to include the standard $TEXMF 
variable (the standard CLUAINPUTS only contains the $SELFAUTOLOC 
variable). 

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

see: [Lua: Building C 
Modules](http://lua-users.org/wiki/BuildingModules)
