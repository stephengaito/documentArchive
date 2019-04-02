---
keywords: 
  - foundations
  - computational
release: draft
authors:
  - Gaito, Stephen
---

## Bootstrapping the JoyLoL compiler

The JoyLoL compiler is self-hosted, this means that it compiles itself. 
Building a self-hosted compiler is a multi-step process. While all JoyLoL 
compilers are, technically, transpilers to ANSI-C, the critically important 
feature of any fully self-hosting JoyLoL compiler is that it produces fully 
verified code. Since ANSI-C compilers are generally not fully verified, we 
need to go through a number of steps to go from "hand written" and 
unverified code to a fully self-hosted and verified JoyLoL compiler.


