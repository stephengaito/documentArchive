# Installation and Dependencies

At the moment this is a source only distribution. This means that you will 
require both runtime and compile tools. 

## Dependencies

### Runtime

* Lua (both v5.2 and v5.3)
-- LuaFileSystem
-- LPeg
* TextAdept
* LuaTeX/ConTeXt

### Compiling

* Lake
* C compiler such as GCC or CLANG (Window's c1 should work but is 
  untested) 

### Testing

* CuTest
* LunaTest
* ConTests

## Installation

All of the following is known to work on XUbuntu (LTS) v16.04. I leave it 
to others to provide installation instructions for other platforms.

### Lua (runtime)

To install [Lua](https://www.lua.org/) on a debian derived distribution, 
type: 

> sudo apt-get install lua5.2 liblua5.2-dev

> sudo apt-get install lua5.3 liblua5.3-dev

> sudo apt-get install lua-filesystem-dev lua-lpeg-dev

### Textadept (runtime)

[Textadept](https://foicica.com/textadept/) is fairly easy to install. 
Follow the instructions outlined in the [Installation section of the 
Textadept Manual](https://foicica.com/textadept/manual.html#Installation). 
The actual binary distributions can be found on the [Download 
page](http://foicica.com/textadept/download). It is good practice to use 
PGP to check the security of the distribution. The installation 
instructions include a section on how to do this. 

### LuaTeX/ConTeXt (runtime)

A binary version of [LuaTeX](http://www.luatex.org/) is contained in 
standard distribution of [ConTeXt](http://www.contextgarden.net/). 

You have two primary ways to install ConTeXt:

* If you will be working with LaTeX (or any other of the family of TeX 
systems) you will probably want to install 
[TeXLive](https://www.tug.org/texlive/) (note that MiKTeX's version of 
LuaTeX and ConTeXt are very old and [probably 
broken](http://wiki.contextgarden.net/MikTeX)). 

* If intend to make extensive use of ConTeXt, then the most well tested 
version will be one of ConTeXt's 
[Standalone](http://wiki.contextgarden.net/ConTeXt_Standalone) versions, 
as these are the versions which the LuaTeX and ConTeXt teams regularly 
use. 

To **install** *LuaTeX/ConTeXt using the TeXLive distribution* you can 
either use your distribution tools of [TeXLive's installation 
tools](https://www.tug.org/texlive/acquire-netinstall.html). Using the 
TeXLive's own installation tools will give you the most up-to-date 
version. 

To **install** *LuaTeX/ConTeXt using the ConTeXt standalong distribution* 
you should follow the instructions for your OS provided by the [ConTeXt 
standalone page](http://wiki.contextgarden.net/ConTeXt_Standalone). 

### Lake (compiling)

[Lake](https://github.com/stevedonovan/Lake) is the Lua based build tool 
used by this project. Installation is easy. On a Unix based system type:

> cd /usr/local/bin

> sudo wget https://github.com/stevedonovan/Lake/raw/master/lake

> sudo chmod a+x lake

### C compiler

Any ANSI-C compiler should be able to compile the JoyLoL code. You will 
need to ensure you obtain one compatible with your OS. 

On a debian derived distribution, type:

> sudo apt-get install gcc

or 

> sudo apt-get install clang

On a windows platform Visual Studio's 'c1' should work, as should the 
gcc/clang systems provided by either [Cygwin](https://www.cygwin.com/) or 
[MinGW](http://www.mingw.org/). However none of these compilers have been 
tested. 

### CuTest (testing ANSI-C code)

[CuTest](https://github.com/asimjalis/cutest) is used to test the ANSI-C 
code. To do this we use the [modified 
version](https://github.com/stephengaito/cutest/tree/combined). Type:

> ./bin/getCuTest

### LunaTest (testing Lua code)

[LunaTest](https://github.com/silentbicycle/lunatest) is used to test the 
Lua code in both the Lua and TextAdept directories. Again we use the 
[modified version](https://github.com/stephengaito/lunatest). 

> ./bin/getLunaTest

### ConTests (testing ConTeXt code)

