#lang scribble/manual

@(require "utils.rkt")

@(require
  (for-label
    racket
    STLCAlg/namesData
    STLCAlg/typesData
  )
)

@title[#:tag "typesData"]{STLCAlg typesData}
@(author-stg)

@defmodule[STLCAlg/typesData]

The @racketmodname[STLCAlg/typesData] module implements the STLCAlg 
types data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (kind?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a kind.
}

@defproc[
  (kind)
  kind?
]{
Returns a kind.
}

@defproc[
  (type? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a type.
}

@defproc[
  (tfree-type?
    [ someThing any ]
  )
  boolean?
]{
Returns a true if someThing is a TFree type.
}

@defproc[
  (tfree-type
    [ aTypeName name? ]
  )
  tfree-type?
]{
Returns a TFree type.
}

@defproc[
  (tfree-type-name
    [ aTFreeType tfree-type? ]
  )
  name?
]{
Returns a the name of the TFree type.
}

@defproc[
  (func-type?
    [ someThing any ]
  )
  boolean?
]{
Returns a true if someThing is a Func type.
}

@defproc[
  (func-type
    [ domainType type? ]
    [ rangeType type? ]
  )
  func-type?
]{
Returns a Function type.
}

@defproc[
  (func-type-domain
    [ aFuncType func-type? ]
  )
  type?
]{
Returns the domain type of the func type.
}

@defproc[
  (func-type-range
    [ aFuncType func-type? ]
  )
  type?
]{
Returns the range type of the func type.
}
