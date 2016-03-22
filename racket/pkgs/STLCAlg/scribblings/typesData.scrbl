#lang scribble/manual

@(require STLCAlg/typesData
          "utils.rkt")
@(require (for-label racket STLCAlg/typesData))

@title[#:tag "types"]{STLCAlg typesData}
@(author-stg)

@defmodule[STLCAlg/typesData]

The @racketmodname[STLCAlg/typesData] module implements the STLCAlg 
types data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (name? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a name.
}

@defproc[
  (global-name? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a global name.
}

@defproc[
  (global-name
    [ aString string? ]
  )
  global-name?
]{
Returns a global name.
}

@defproc[
  (global-name-str
    [ aGlobalName global-name? ]
  )
  string?
]{
Returns the name of the global name.
}

@defproc[
  (local-name? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a local name.
}

@defproc[
  (local-name
    [ aNumber number? ]
  )
  local-name?
]{
Returns a local name.
}

@defproc[
  (local-name-index
    [ aLocalName local-name? ]
  )
  number?
]{
Returns the index of the local name.
}

@defproc[
  (quote-name? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a quote name.
}

@defproc[
  (quote-name
    [ aNumber number? ]
  )
  quote-name?
]{
Returns a quote name.
}

@defproc[
  (quote-name-index
    [ aQuoteName quote-name? ]
  )
  number?
]{
Returns the index of the quote name.
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
