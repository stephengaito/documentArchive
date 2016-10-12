# Sprint 001 initial implementation of Joy

* Started: 2016/10/06
* Ends: 2016/10/12

## Problem

Provide a simple and clean implementation of [Manfred von Thun's Joy 
programming 
language](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language).

## Tasks

* Provide a minimally working implementation of Joy.

* Work through examples from "Joy: Forth's Functional Cousin" and the 
factorial/Y-combinator example in "Recursion Theory and Joy".

## Features

* provide an implementation of Joy.

* provide ability to trace the execution of a Joy program.

* ability to extend the Joy language with both Joy-level code (in both 
racket and joy code) as well as Racket-level code.

* ability to load an external extension (racket) module.

* Provide a worked example of how to define a Racket Language

* Make use of Racket Macros to "compile" Joy extensions in Racket.

* Provide a tool to run REPL level tests of the Joy implementation.

## Specifications

* [repl/rJoySpec](../../specs/repl/rJoySpec.rkt)

* [unit/coreJoySpec](../../specs/unit/coreJoySpec.rkt)

## Questions and Risks

* How much "local" memory is required. For the diSimp language we need 
to use as little as possible.

* Understand the interplay between code and data on the stack.

* Understand how to remove dependence upon ASCII (or *any* characters). 
The core diSimp implementation must only use Lists of Lists.

* Understand how to implement a parallel version of Joy.

## Resources

[Juan Iiapina's "Writing a
Language"](http://juanibiapina.com/articles/2014-10-03-writing-a-language/)

[Racket Guide's "Creating
Languages"](https://docs.racket-lang.org/guide/languages.html)

[).4 (page 271) of "Realm of
Racket"](https://www.nostarch.com/realmofracket)

## Wrap-up

* completed satisfactorily
