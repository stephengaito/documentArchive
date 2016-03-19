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

The Mathematical and Philosophyical ideas which this interpreter is
implementing can be found in the companion papers TODO.

@local-table-of-contents[]

@;include-section["interpreter.scrbl"]
@;include-section["listExps.scrbl"]

