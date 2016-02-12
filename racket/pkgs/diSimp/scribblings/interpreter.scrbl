#lang scribble/manual

@(require diSimp/interpreter
          "utils.rkt")

@title[#:tag "interpreter"]{diSimplex interpreter}
@(author-stg)

@defmodule[diSimp/interpreter]

The @racketmodname[diSimp/interpreter] module implements the diSimplex 
interpreter using the Racket dialect of Scheme/Lisp.

@defproc[
  (interpret 
    [ verbose-mode parameter? ]
    [ sExp list? ]
  )
  list?
]{

Interprets a single s-exp.

}
