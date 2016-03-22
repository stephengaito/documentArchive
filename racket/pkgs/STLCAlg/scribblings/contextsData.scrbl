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
  (env?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an env.
}

@defproc[
  (empty-env?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an empty env.
}

@defproc[
  (empty-env)
  empty-env?
]{
Returns an empty env.
}

@defproc[
  (extend-env?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an extend env.
}

@defproc[
  (extend-env
    [ aName    name? ]
    [ someInfo info? ]
    [ anEnv    env?  ]
  )
  extend-env?
]{
Returns an extended env.
}

@defproc[
  (extend-env-name
    [ anExtendEnv extend-env? ]
  )
  name?
]{
Returns the extend env's name.
}

@defproc[
  (extend-env-info
    [ anExtendEnv extend-env? ]
  )
  info?
]{
Returns the extend env's info.
}

@defproc[
  (extend-env-next
    [ anExtendEnv extend-env? ]
  )
  env?
]{
Returns the extend env's next env.
}

@defproc[
  (get-info-env
    [ anEnv env? ]
    [ aName name? ]
  )
  info? ]{
Searches the env for the info corresponding to the name provided. Returns 
null if not such name have been found.
}
