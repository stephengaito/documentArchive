**Table of Contents**

  - [Sprint 004 diSimp Interpreter](#sprint-004-disimp-interpreter)
    - [Problem](#problem)
    - [Tasks](#tasks)
    - [Features](#features)
    - [Specifications](#specifications)
    - [Questions and Risks](#questions-and-risks)
    - [Resources](#resources)
    - [Wrap-up](#wrap-up)

<!--- END TOC -->

# Sprint 004 diSimp Interpreter

* Started: 2016/09/23
* Ends: 2016/09/30

## Problem

We need to build a simple (but maybe not the simplest) Turing complete 
diSimp interpreter.

The interpreted diSimp language should be minimal but Turing complete.

The semantics should be as close as possible to a fixed point.

## Tasks

1. write a diSimp function which takes a list and executes the head of 
the list to return a list.

## Features

We loosely base our diSimp language and its interpreter on a 
simplification/lisp-ification of the [Joy 
language](http://www.kevinalbrecht.com/code/joy-mirror/joy.html) see 
also [XIE YuHeng's mirror on GitHub](https://github.com/xieyuheng/joy)

We will embedd this interpreter in a 
[Racket](https://docs.racket-lang.org/) based tool chain. This will 
provide a sufficient parser for "free". This will also provide tight 
control, via the use of diSimpRacketLayer, of the aspects of the 
underlying Racket language used in the interpreter.

We use the [XREPL](https://docs.racket-lang.org/xrepl/) to provide a 
useful command line based tool to interact with and explore the 
interpreter.

## Specifications

* [diSimpSpec](../../pkgs/diSimpInterpreter/specs/functional/operatorsSpec.rkt)

## Questions and Risks

The semantics of the data should be the identity. Unfortunately I do not 
yet understand how to add process features and keep the semantics a 
strict identity.

## Resources

## Wrap-up
