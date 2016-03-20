#lang scribble/manual

@(require diSimp/terms
          "utils.rkt")
@(require (for-label racket diSimp/terms))

@title[#:tag "terms"]{diSimplex terms}
@(author-stg)

@defmodule[diSimp/terms]

The @racketmodname[diSimp/terms] module implements the diSimplex 
terms data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (term? 
    [ aTerm list-exp? ]
  )
  boolean?
]{

Returns true if aTerm is a term.

}
