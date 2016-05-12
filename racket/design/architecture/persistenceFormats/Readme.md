**Table of Contents**

  - [Persistence formats](#persistence-formats)
    - [Problem](#problem)
    - [Goals](#goals)
    - [Requirements](#requirements)
    - [Solution](#solution)
    - [Questions and Risks](#questions-and-risks)

<!--- END TOC -->

# Persistence formats

## Problem

We have four primary artefacts:

 1. a description of a language's syntax.

 1. a list of a language's axioms.

 1. one or more computational theorem statements together with their 
    proofs

 1. a description of an interpretation of one language into another.

For each of these primary artefacts we have the problem of recognising, 
storing and navigating over large collections of these artefacts.

## Goals

We will need a comfortable user interface with which to manipulate these 
artefacts both individually and collectively. 

Given that these artefacts represent an evolving part of mathematics, the 
use of [LaTeX](https://www.latex-project.org/) and 
[MathJAX](https://www.mathjax.org/) in the front end of any user 
interface strongly suggests the eventual use of javascript in the 
frontend.

Given that these artefacts are substantially about self-referential 
language manipulation, the use of Racket/LISP in the backend and the 
compiler is highly likely.

## Requirements

> Persistent artefacts WILL be stored in Racket readable files.

> Collections of a persistence artefacts WILL be stored in a file system 
> directory tree.

> It MUST be possible to *reliably* transfer these artefacts over TCP/IP 
> between a browser/server based User Interface.

> It MUST be possible to *reliably* reconstruct these artefacts in either 
> Racket/LISP or javascript/typescript.

> We MUST have a meta^n-level description of all of these artefacts.

> This meta^n-level description SHOULD be a context-free description of a 
> language ASTs.

> In the Racket/LISP backend/compiler this meta^n-level SHOULD be 
> describing S-expressions.

## Solution

In the **backend**, we will use Racket/LISP S-expressions, both 
internally and as a persistence format.

In the **frontend**, we will base our javascript S-expression parser on 
code taken from the 
[littlelisp](https://github.com/maryrosecook/littlelisp) project. This 
code will be maintained in synchrony with the meta^n-level description 
format. This code will map the syntactic elements of the meta^n-level 
description into corresponding objects in the [**ES6** javascript 
specification](http://www.ecma-international.org/ecma-262/6.0/) (and or 
libraries of objects).

## Questions and Risks

**How should we represent these artefacts over the TCP/IP wire?**

Consider wire-transfer using JSON. Unfortunately this does not allow 
Racket/LISP symbols to be distinguished from strings.

Could consider [ragg](http://www.hashcollision.org/ragg/)
[example](http://stackoverflow.com/a/12358029) and [Lexical analysis in
Racket](http://matt.might.net/articles/lexers-in-racket/) and the example
[Parsing BibTeX](http://matt.might.net/articles/parsing-bibtex/). See
also [HashCollision's projects](http://www.hashcollision.org/). See also
[Racket
Parsers](http://www.markcarter.me.uk/programming/racket/parsers.htm).

After some research with NodeJS, Angular 2, and Jasmine I have discovered 
that a better method of moving data structures between Racket and Angular 
might be as stringified S-expressions.  Try using the reader/parser from 
the [SLip](https://github.com/mishoo/SLip) project. OR try 
[littlelisp](https://github.com/maryrosecook/littlelisp). Alternatively 
consider [PEG.js](http://pegjs.org/)

After some additional research I have found that the littlelisp based 
S-expression parser is at least 20 times slower than the native JSON 
parser, but, however, wire-transfer represents a small part of the user's 
experience of the user interface (much more time will be spent 
*thinking*).