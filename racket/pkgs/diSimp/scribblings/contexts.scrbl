#lang scribble/manual

@(require diSimp/contexts
          "utils.rkt")
@(require (for-label racket diSimp/contexts))

@title[#:tag "contexts"]{diSimplex contexts}
@(author-stg)

@defmodule[diSimp/contexts]

The @racketmodname[diSimp/contexts] module implements the diSimplex 
contexts data structures using the Racket dialect of Scheme/Lisp.

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
  (info?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an info.
}

@defproc[
  (kind-info?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a kind info.
}

@defproc[
  (kind-info
    [ aKind kind? ]
  )
  kind-info?
]{
Returns a kind info.
}

@defproc[
  (kind-info-kind
    [ aKindInfo kind-info? ]
  )
  kind?
]{
Returns the kind of the kind info.
}

@defproc[
  (type-info?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a type info.
}

@defproc[
  (type-info
    [ aType type? ]
  )
  type-info?
]{
Returns a type info.
}

@defproc[
  (type-info-type
    [ aTypeInfo type-info? ]
  )
  type?
]{
Returns the type of the type info.
}

