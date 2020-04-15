# Mixing Assembler/ANSI-C with Go code

## JoyLoL calling convention

We will use a FORTH-like architecture based on [MOVING FORTH Part 1: 
Design Decisions in the Forth Kernel by Brad 
Rodriguez](https://www.bradrodriguez.com/papers/moving1.htm), [MOVING 
FORTH Part 2: Benchmarks and Case Studies of Forth Kernels by Brad 
Rodriguez](https://www.bradrodriguez.com/papers/moving2.htm) and [Jones 
FORTH (see 
jonesforth.S)](http://git.annexia.org/?p=jonesforth.git;a=shortlog;h=refs/heads/master). 
(Note that JonesFORTH has a number of updates in various copies on 
GitHub). 

We might also consider [ nimblemachines / muforth 
](https://github.com/nimblemachines/muforth) (self hosted written in C) or 
[ larsbrinkhoff / lbForth ](https://github.com/larsbrinkhoff) (self 
compiling with a bootstrap in Lisp). 

## Discovering Calling Conventions

Using the correct [Calling 
Conventions](https://en.wikipedia.org/wiki/Calling_convention) is critical 
to mixing ANSI-C and Assembler code. 

Use `go build -a -n` to see all of the compilation steps that `go build` 
uses for your code. In particular you should be able to find the command 
line (complete with explicit compile switches) used to compile your `*.c` 
or `*.s` code. You can then "replay" this command (with $WORK arguments 
removed) together with the `-S` switch to have ANSI-C code translated to 
the corresponding Assembler code. This will help you discover what the 
calling conventions are for your particular code. To get the most literal 
translation of your code, you may need to remove the `-Ox` switch to turn 
off optimization. 

`go build` keeps the code re-entrant by using the `-fPIC` `gcc` switch.

## Keeping differtent assembler code versions

ANSI-C (and I presume) Assembler code can be kept in separate files using 
the `xxx_amd64.c` or `xxx_arm64.c` file names. `go build` will correctly 
choose the correct file for the corresponding architecture. 

## ARM port (Cross compiling from AMD64->ARMv7)

My Raspberry PI 3 B+ uses an ARMv7 architecture which requires the 
`gcc-arm-linux-gnueabihf` (gnueabi with "hard(ware) float") package to be 
installed. (see: https://askubuntu.com/a/250721) 

When cross compiling you must explicitly tell `go build` to use `cgo` using the 
environment variable `export CGO_ENABLED=1`. (See: "cross compile" in 
https://golang.org/cmd/cgo/) 

To ensure the correct (cross) compiler is used you must specify the 
`export CC=arm-linux-gnueabihf-gcc` AND `export GOARCH=arm` (Again see: 
"cross compile" in https://golang.org/cmd/cgo/ however, the 
`CC_FOR_linux_arm` did not seem to work so I explicitly used `CC` instead) 

Alternatively you can specify all of this on the `go build` command line:

```
  CGO_ENABLED=1 CC=arm-linux-gnueabihf-gcc GOARCH=arm go build
```

## Resources: 

- [GOS and GOARCH 
values](https://gist.github.com/asukakenji/f15ba7e588ac42795f421b48b8aede63) 
  - 386, amd64, arm, arm64

- [GNU Assembler Examples 
(AMD64)](https://cs.lmu.edu/~ray/notes/gasexamples/) 

- [Embedded Systems/Mixed C and Assembly 
Programming](https://en.wikibooks.org/wiki/Embedded_Systems/Mixed_C_and_Assembly_Programming) 

- [Embedded Systems/Mixed C and Assembly: Programming Calling 
Conventions](https://en.wikibooks.org/wiki/Embedded_Systems/Mixed_C_and_Assembly_Programming#Calling_Conventions) 

- [Instruction Set Simulation in 
C](https://www.embedded.com/instruction-set-simulation-in-c/) 

- [muFORTH](https://github.com/nimblemachines/muforth)


