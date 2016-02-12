#lang scribble/manual

@(require diSimp/listExps
          "utils.rkt")

@title[#:tag "listExps"]{List Expression data type}
@(author-stg)

@defmodule[diSimp/listExps]

The @racketmodname[diSimp/listExps] module implements the List Expression 
data type for the diSimplex interpreter.

@defproc[
  (null-list-exp?
    [ listExp list? ]
  )
  boolean?
]{

Returns @racket[#t] if listExp represents a null list, @racket[#f] 
otherwise.

}
