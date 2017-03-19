# Joy concatenative programming language based on Lists of Lists

We provide an implementation in [Lua](https://www.lua.org/) and ANSI-C 
of a form of [Manfred von Thun's Joy programming 
language](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language) 
which is restricted to manipulating Lists of Lists.

This implementation can be used in three distinct platforms:

1. [Lua](https://www.lua.org/) a light weight embeddable scripting 
language written in ANSI-C.

2. [Textadept](https://foicica.com/textadept/) a programmer's text 
editor and IDE (which embeds Lua).

3. [ConTeXt](http://www.contextgarden.net/)/[LuaTeX](http://www.luatex.org/) 
a type setting system based upon Knuth's [TeX](https://www.tug.org/) 
(which embeds Lua).

## Installation and Dependencies

At the moment this is a source only distribution. A detailed description 
of how to install all of the tools required to install and build this 
distribution can be found in the file [Install](Install.md). 

## License

All C, Lua, and ConTeXt code (*.c, *.h, *.lua, *.mkiv files) is, except 
where specifically noted, Copyright (C) PercpetiSys Ltd (Stephen Gaito) 
and released under an [MIT License](License.md). See the associated 
[License.md](License.md) file.

All ConTeXt documents (*.tex files) are Copyright (C) PerceptiSys Ltd 
(Stephen Gaito) and released under a [Creative Commons 
Attribute-ShareAlike license](http://creativecommons.org/licenses/by-sa/4.0/).

We make use of three test frameworks with their own licenses:

###  CuTest License (based on zlib/libpng) 

CuTest is used for testing ANSI-C code.

The instance of the CuTest framework, contained in the

>  lua/specs/cuTest 

directory, has been taken from the combined (notEqualsAssertions + 
namedSubSuites) branch of the GitHub project 
[stephengaito/cutest](https://github.com/stephengaito/cutest) forked 
from [asimjalis/cutest](https://github.com/asimjalis/cutest). As such 
the CuTest framework files remain under Asim Jalis's original license. 
See the license.txt file in the lua/specs/cuTest directory.

### LunaTest MIT License 

LunaTest is use for testing the Lua code. 

The file:

>  lua/specs/lunaTest/lunatest.lua

has been taken from Scott Volkes' Lunatest github repository:

>  https://github.com/silentbicycle/lunatest

it is copyright:

>  Copyright (c) 2009-12 Scott Vokes <vokes.s@gmail.com>

and is used under the MIT License which can be found at the 
top of the file:

>  lua/specs/lunaTest/lunatest.lua

### ConTests MIT License

ConTests is used for testing ConTeXt code. It is used as a standard 
ConTeXt module and hence is not distributed with this project.


