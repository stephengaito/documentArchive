**Table of Contents**

  - [Sprint 003 language syntax](#sprint-003-language-syntax)
    - [Problem](#problem)
    - [Tasks](#tasks)
    - [Features](#features)
    - [Specifications](#specifications)
    - [Questions and Risks](#questions-and-risks)
    - [Resources](#resources)
    - [Wrap-up](#wrap-up)

<!--- END TOC -->

# Sprint 003 language syntax

* Started: 2016/05/26
* Paused: 2016/05/26 (while working on external websites)
* Restarted: 2016/06/13
* Paused: July/August/September (while on holiday/rebuiding systems)
* Restarted: 2016/09/19
* Postponed: 2016/09/23 (while working on diSimpInterpreter)
* Ends: unknown

## Problem

We are designing a heavily data driven tool suite. The whole idea is that 
we can specify languages and define computation in terms of rewriting of 
the ASTs of these languages.

We need to specify the meta-syntax of langauges

**Risk** As mathematicians and scientists we *need* languages which are 
precise, as humans we *like* languages which are ambiguous and 
context-sensitive. What level of context-sensitivity is sufficient to 
make a language humanly easy to work with, without compromising 
precision.

## Tasks

* For the "List of List" (LoL) language and its meta-description:

  * Be able to specify a language syntax

  * Be able to specify language axioms

  * Provide a language mapping of the meta-description into the LoL 
    language.

* Build a simple tool to read a context-free description of an AST and 
  compile it into a collection of Racket structures.

* Load a language artefact

* Be able to write out a simple computational "proof"

* Rudimentary verification of a simple "proof"

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

## Resources

* [Racket documentation](https://docs.racket-lang.org/)

* [Racket web applications](https://docs.racket-lang.org/web-server/)


## Wrap-up

Nothing at the moment.