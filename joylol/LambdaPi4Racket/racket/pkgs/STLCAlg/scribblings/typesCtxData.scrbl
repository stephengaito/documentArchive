#lang scribble/manual

@(require "utils.rkt")

@(require 
  (for-label 
    racket
    STLCAlg/namesData
    STLCAlg/typesData
    STLCAlg/typesCtxData
  )
)

@title[#:tag "typesCtxData"]{STLCAlg typesCtxData}
@(author-stg)

@defmodule[STLCAlg/typesCtxData]

The @racketmodname[STLCAlg/typesCtxData] module implements the STLCAlg 
contexts data structures using the Racket dialect of Scheme/Lisp.

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
  (ctx?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an ctx.
}

@defproc[
  (empty-ctx?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an empty ctx.
}

@defproc[
  (empty-ctx)
  empty-ctx?
]{
Returns an empty ctx.
}

@defproc[
  (extend-ctx?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an extend ctx.
}

@defproc[
  (extend-ctx
    [ aName    name? ]
    [ someInfo info? ]
    [ anCtx    ctx?  ]
  )
  extend-ctx?
]{
Returns an extended ctx.
}

@defproc[
  (extend-ctx-name
    [ anExtendCtx extend-ctx? ]
  )
  name?
]{
Returns the extend ctx's name.
}

@defproc[
  (extend-ctx-info
    [ anExtendCtx extend-ctx? ]
  )
  info?
]{
Returns the extend ctx's info.
}

@defproc[
  (extend-ctx-next
    [ anExtendCtx extend-ctx? ]
  )
  ctx?
]{
Returns the extend ctx's next ctx.
}

@defproc[
  (exn-name-not-found-in-context?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is a name-not-found-in-context 
exception.
}

@defproc[
  (get-info-ctx
    [ aCtx ctx? ]
    [ aName name? ]
  )
  (or info? exn-name-not-found-in-context?)
]{

Searches the ctx for the info corresponding to the name provided. 

Returns the info corresponding to aName if the context contains aName.

Raises the @racket[exn-name-not-found-in-context?] exception otherwise.

}
