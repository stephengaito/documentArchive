#lang scribble/manual

@(require diSimp/interpreter
          "utils.rkt")
@(require (for-label racket diSimp/listExps diSimp/interpreter))

@title[#:tag "interpreter"]{diSimplex interpreter}
@(author-stg)

@defmodule[diSimp/interpreter]

The @racketmodname[diSimp/interpreter] module implements the diSimplex 
interpreter using the Racket dialect of Scheme/Lisp.

@defproc[
  (interpret 
    [ verbose-mode parameter? ]
    [ sExp list-exp? ]
  )
  list-exp?
]{

Interprets a single s-exp.

}
