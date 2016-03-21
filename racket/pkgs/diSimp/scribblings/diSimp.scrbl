#lang scribble/manual

@(require "utils.rkt")

@title[#:tag "top"]{diSimp}
@(author-stg)

@defmodule[diSimp]

The @racketmodname[diSimp] language provides the code to implement the
diSimplex interpreter.

The initial interpreter is based upon the 
@hyperlink["https://www.andres-loeh.de/LambdaPi/"]{lambdaPi} tutorial, "A 
Tutorial Implementation of a Dependently Typed Lambda Calculus", by 
Andres Löh, Conor McBride and Wouter Swierstra.

They implement the call-by-value (strict) Lambda Calculus. Since we are
explicitly defining the co-algebraic (non-well-founded) foundations of
mathematics, we will implement the call-by-name/call-by-need (lazy)
Lambda Calculus. Discussions of the semantics of the
call-by-name/call-by-need version of the simply typed Lambda Calculus can
be found in either of the books:
@hyperlink["https://mitpress.mit.edu/books/semantics-programming-languages"]{
Semantics of Programming Languages: Structures and Techniques} by
@hyperlink["http://web.engr.illinois.edu/~cgunter/"]{Carl A. Gunter} or
@hyperlink["https://mitpress.mit.edu/books/formal-semantics-programming-languages"]{The
Formal Semantics of Programming Languages: An Introduction} by
@hyperlink["https://www.cl.cam.ac.uk/~gw104/"]{Glynn Winskel}.

The ideas for how to implement this interpreter have been adapted from
@hyperlink["http://www.eopl3.com/"]{Essentials of Programming Languages}
and both editions of
@hyperlink["https://cs.brown.edu/~sk/Publications/Books/ProgLangs/2007-04-26/"]{Programming
Languages: Application and Interpretation}.

The primary aim of the diSimp interpreter @emph{is @bold{not}} to be 
performant. It is instead meant to provide a rigorous ``proof'' that what 
are defined to be a computational non-well-founded foundations for 
mathematics actually computes what we say it does.

To keep to this aim, we will re-implement many of the tools that the 
Racket programming system conviently provides. We do this so that we can 
provide rigorous proofs that our versions of these tools are correct. We 
also re-implement these tools to show exactly what tools and parts of 
Pure LISP that is required to provide our version of the foundations of 
mathematics. The @hyperlink["../racketLayer/index.html"]{racketLayer} 
language provides an explicit definition of those parts of the Racket 
programming language we consider to be part of Pure LISP.

Future work may (or may not) provide more performant re-implementations 
of the diSimp language.

We structure this ``interpreter'' as a collection of ``cross-compilers'' 
or Racket syntax transformers. This ensures we are able to identify the 
cross-compiled Pure LISP version of any diSimp language construct.

In order to capture the whole of classical Mathematics, we will 
eventually define Pure LISPs which are capable of computing any 
particular trans-finite cardinal.  This means that these @emph{are} 
``cross-compilers''. They cross-compile from an $\omega$-Pure LISP 
program to any other specific cardinal powered Pure LISP.

Since the Racket programming system can itself be considered as an 
interpreter, we will use EOPL's proceedural representation (section 
2.2.3) to provide both more performant and more importantly a more 
extensible system.

The Mathematical and Philosophyical ideas which this interpreter is
implementing can be found in the companion papers TODO.



@local-table-of-contents[]

@include-section["types.scrbl"]
@include-section["terms.scrbl"]
@include-section["values.scrbl"]
@include-section["contexts.scrbl"]

