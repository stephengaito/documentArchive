# A Joy(ful) concatenative programming language based on Lists of Lists

We provide an implementation of JoyLoL written in itself and (minimally) 
wrapped in [Lua](https://www.lua.org/). JoyLoL is a form of [Manfred von 
Thun's Joy programming 
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

All JoyLoL, C, Lua, and ConTeXt code (*.joy, *.c, *.h, *.lua, *.mkiv 
files) is, except where specifically noted, Copyright (C) PercpetiSys Ltd 
(Stephen Gaito) and released under an [MIT License](License.md). See the 
associated [License.md](License.md) file. 

All ConTeXt documents (*.tex files) are Copyright (C) PerceptiSys Ltd 
(Stephen Gaito) and released under a [Creative Commons 
Attribute-ShareAlike license](http://creativecommons.org/licenses/by-sa/4.0/).
