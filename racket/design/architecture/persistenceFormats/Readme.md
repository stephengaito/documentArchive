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

In the **frontend**, we will simply use div structures provided by the 
backend to display any S-expressions.

## Questions and Risks

**How should we represent these artefacts over the TCP/IP wire?**

  * Simply use div structures provided by the backend

  * Occasionally (for menus) make use of JSON structures.