**Table of Contents**

  - [DiSimplex compilation tools - Proving computations correct](#disimplex-compilation-tools-proving-computations-correct)
    - [Problem](#problem)
    - [Design goals](#design-goals)
    - [Tools](#tools)
    - [Resources](#resources)
      - [Frontend](#frontend)

<!--- END TOC -->

# DiSimplex compilation tools - Proving computations correct

## Problem

Mathematics is the subtle interplay between language interpretation and 
language rewriting, both viewed as computation.

A "computation" is a collection of language rewriting steps.

A "computation" which is "proven" to be "correct" is a collection of 
language rewriting steps which when given a language structure 
satisfying a given pre-condition, computes a resulting language 
structure which satisfies a given post-condition, using only either 
axiomatic rewriting rules, or computations which have been previously 
been proven correct.

Our primary objective is to build a cross compiler which will only 
"compile" a computation which is provably correct. If a non-trivial 
language interpretation is provided, then the *cross* compiler compiles 
the computation into a computation of the interpreted language.

The List of Lists language is the simplest possible language which has 
itself as its own semantic interpretation.

## Design goals

We want to build a *simple* collection of computational tools which 
allows us to:

1. define the syntax of a given language

2. denote a computational structure which is provably correct.

3. construct a computational structure.

4. persist a computational structure.

5. verify the correctness of a computational structure.

6. navigate the category of previously proven correct computational 
   structures

7. construct an (semantic) interpretation.

8. persist an interpretation.

9. navigate the category of interpretations.

Since the primary concept is language interpretation/rewriting, the 
central data structure is quite naturally an Abstract Syntax Tree (AST 
or List of Lists). LISP and in particular the Racket subdialect of 
LISP, is well suited to both the manipulation of ASTs, as well as the 
manipulation and interpretation of "Syntax" structures. Hence the most 
appropriate language to use on (at least) the server is Racket.

Initially we will not bother to define any syntaxtic structures other 
than the ASTs themselves. Tools to read relatively arbitrary "input" 
languages and translate them into ASTs will eventually be important, 
but by and large this is a relatively well understood problem. We will 
focus instead on the AST manipulation and interpretation.

## Tools

1. a basic programmer's text editor to edit flat text files of 
   computational structures.

2. a cross compiler which verifies a computational structure and cross 
   compiles it if the given interpretation is not the identity 
   interpretation.

3. a browser/frontend + server/persistent-layer pair of tools to 
   graphically navigate the collection of computational structures and 
   interpretation mappings, which can be used to interactively construct a 
   computational structure or interpretation mapping.

## Resources

### Frontend

* [Deconstructing Single Page Applications at 
CodeMash](https://spin.atomicobject.com/2015/01/16/deconstructing-single-page-applications/)

* [Rich JavaScript Applications – the Seven Frameworks (Throne of JS, 
2012)](http://blog.stevensanderson.com/2012/08/01/rich-javascript-applications-the-seven-frameworks-throne-of-js-2012/)

* [AngularJS](https://angularjs.org/)

* [Backbon.js](http://backbonejs.org/)