#lang scribble/manual

@(require STLCAlg/contextsData
          "utils.rkt")
@(require (for-label racket STLCAlg/contextsData))

@title[#:tag "contexts"]{STLCAlg contextsData}
@(author-stg)

@defmodule[STLCAlg/contextsData]

The @racketmodname[STLCAlg/contextsData] module implements the STLCAlg 
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

@defproc[
  (cxt?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an cxt.
}

@defproc[
  (empty-cxt?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an empty cxt.
}

@defproc[
  (empty-cxt)
  empty-cxt?
]{
Returns an empty cxt.
}

@defproc[
  (extend-cxt?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an extend cxt.
}

@defproc[
  (extend-cxt
    [ aName    name? ]
    [ someInfo info? ]
    [ anCxt    cxt?  ]
  )
  extend-cxt?
]{
Returns an extended cxt.
}

@defproc[
  (extend-cxt-name
    [ anExtendCxt extend-cxt? ]
  )
  name?
]{
Returns the extend cxt's name.
}

@defproc[
  (extend-cxt-info
    [ anExtendCxt extend-cxt? ]
  )
  info?
]{
Returns the extend cxt's info.
}

@defproc[
  (extend-cxt-next
    [ anExtendCxt extend-cxt? ]
  )
  cxt?
]{
Returns the extend cxt's next cxt.
}

@defproc[
  (get-info-cxt
    [ anCxt cxt? ]
    [ aName name? ]
  )
  info? ]{
Searches the cxt for the info corresponding to the name provided. Returns 
null if not such name have been found.
}
