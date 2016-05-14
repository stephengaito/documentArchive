**Table of Contents**

  - [Sprint 001 initial planning](#sprint-001-initial-planning)
    - [Problem](#problem)
    - [Tasks](#tasks)
    - [Features](#features)
    - [Specifications](#specifications)
    - [Questions and Risks](#questions-and-risks)
    - [Resources](#resources)
    - [Wrap-up](#wrap-up)

<!--- END TOC -->

# Sprint 001 initial planning

* Started: 2016/05/09
* Extended: 2016/05/13
* Ends: 2016/05/20 Friday

## Problem

We are designing a heavily data driven tool suite. The whole idea is that 
we can specify languages and define computation in terms of rewriting of 
the ASTs of these languages.

One of the key issues of a data driven system is that its driving data 
gets complex very quickly. This suggests a tool to visualise and navigate 
this collection of data is important.

**Risk** As mathematicians and scientists we *need* languages which are 
precise, as humans we *like* languages which are ambiguous and 
context-sensitive. What level of context-sensitivity is sufficient to 
make a language humanly easy to work with, without compromising 
precision.

## Tasks

* Be able to specify a language syntax
 * Be able to specify a language syntax
 * Be able to specify language axioms

* Build a simple tool to read a context-free description of an AST and 
  compile it into a collection of Racket structures.

* Load a language artefact

* Be able to write out a simple computational "proof"

* Rudimentary verification of a simple "proof"

* build a simple frontend/backend using Angular2/Racket

All of the above are to be as simple as possible using flat Racket/text files.

## Features

## Specifications

## Questions and Risks

* Need to agree/document file formats for
 * language syntax
 * language axioms
 * computational "proofs"

* How are these files formats "implemented"/recognised/interpreted in the 
tool set?

* How are the persistent forms of the above file formats organised?

* We will eventually build a user interactive tool which is likely to 
comprise a web/javascript based frontend coupled with a Racket 
server/backend. This means that we have to find a transport medium which 
allows the complexity of a language structure to be transferred back and 
forth between the front and backends.

  * We have experimented with using the obvious JSON (wire) format but 
    this does not allow, for example, Racket symbols to be reliably 
    transferred.

  * We have experimented with using LISP/Racket S-expressions. Using code 
    extracted from some MIT licensed code 
    ([littlelisp](https://github.com/maryrosecook/littlelisp)) we can 
    very reliably transfer S-expressions and have a great deal of control 
    over how they are transcribed into javascript.

  * Unfortunately the littlelisp parsing code is *at least* 20 times 
    (~1000 parses per second) slower than the native JSON parsing code 
    (~20000 parses per second). However the frontend/backend based tool 
    is a *user integration* tool, so a significantly sub-second hit per 
    user request is probably very easily tolerated.

## Resources

* [Racket documentation](https://docs.racket-lang.org/)

## Wrap-up

Nothing at the moment
