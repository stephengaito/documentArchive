#lang scribble/manual

@(require diSimp/types
          "utils.rkt")
@(require (for-label racket diSimp/types))

@title[#:tag "types"]{diSimplex types}
@(author-stg)

@defmodule[diSimp/types]

The @racketmodname[diSimp/types] module implements the diSimplex 
types data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (type? 
    [ aType any ]
  )
  boolean?
]{

Returns true if aType is a type.

}

@defproc[
  (tfree-type
    [ aTypeName string? ]
  )
  type?
]{

Returns a TFree type.

}

@defproc[
  (func-type
    [ domainType type? ]
    [ rangeType type? ]
  )
  type?
]{

Returns a Function type.

}
