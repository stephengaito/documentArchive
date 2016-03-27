#lang scribble/manual

@(require STLCAlg/namesData
          "utils.rkt")
@(require (for-label racket STLCAlg/namesData))

@title[#:tag "namesData"]{STLCAlg namesData}
@(author-stg)

@defmodule[STLCAlg/namesData]

The @racketmodname[STLCAlg/namesData] module implements the STLCAlg
names data structures using the Racket dialect of Scheme/Lisp.

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


