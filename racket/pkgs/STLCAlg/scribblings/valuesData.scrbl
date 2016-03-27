#lang scribble/manual

@(require STLCAlg/termsData
          STLCAlg/typesData
          STLCAlg/valuesData
          "utils.rkt")

@(require
  (for-label
    racket 
    STLCAlg/termsData
    STLCAlg/typesData
    STLCAlg/valuesData
  )
)

@title[#:tag "valuesData"]{STLCAlg valuesData}
@(author-stg)

@defmodule[STLCAlg/valuesData]

The @racketmodname[STLCAlg/valuesData] module implements the STLCAlg 
values data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (neutral?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a neutral.
}

@defproc[
  (nfree-neutral?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an nFree neutral.
}

@defproc[
  (nfree-neutral
    [ aName name? ]
  )
  nfree-neutral?
]{
Returns an nFree neutral.
}

@defproc[
  (nfree-neutral-name
    [ anNFreeNeutral nfree-neutral? ]
  )
  name?
]{
Returns the nFree neutral's name.
}

@defproc[
  (napp-neutral?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an nApp neutral.
}

@defproc[
  (napp-neutral
    [ aFuncNeutral neutral? ]
    [ anArgValue   value? ]
  )
  napp-neutral?
]{
Returns an nApp neutral.
}

@defproc[
  (napp-neutral-func
    [ anNAppNeutral napp-neutral? ]
  )
  neutral?
]{
Returns the nApp's function neutral.
}

@defproc[
  (napp-neutral-arg
    [ anNAppNeutral napp-neutral? ]
  )
  value?
]{
Returns the nApp's argument value.
}

@defproc[
  (value?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a value.
}

@defproc[
  (vlam-value?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a vLam value.
}

@defproc[
  (vlam-value
    [ aLambdaFunc (-> value? value?) ]
  )
  vlam-value?
]{
Returns a vLam value.
}

@defproc[
  (vlam-value-func
    [ aVLamValue vlam-value? ]
  )
  value?
]{
Returns the function of the VLam value.
}

@defproc[
  (vlam-value-arg
    [ aVLamValue vlam-value? ]
  )
  value?
]{
Returns the argument of the VLam value.
}

@defproc[
  (vneutral-value?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a vNeutral value.
}

@defproc[
  (vneutral-value
    [ aNeutral neutral? ]
  )
  vneutral-value?
]{
Returns a vNeutral value.
}

@defproc[
  (vneutral-value-neutral
    [ aVNeutralValue vneutral-value? ]
  )
  neutral?
]{
Returns the vNeutral value's neutral.
}

@defproc[
  (env?
    [ something any ]
  )
  boolean?
]{
Returns true if something is an env.
}

@defproc[
  (empty-env?
    [ something any ]
  )
  boolean?
]{
Returns true if something is an empty env.
}

@defproc[
  (empty-env)
  empty-env?
]{
Returns an empty env.
}

@defproc[
  (extend-env?
    [ something any ]
  )
  boolean?
]{
Returns true if something is a non-empty (extended) env.
}

@defproc[
  (extend-env
    [ aValue value? ]
    [ anEnv  env? ]
  )
  extend-env?
]{
Extends anEnv by pre-pending the value aValue.
}

@defproc[
  (extend-env-value
    [ anEnv env? ]
  )
  value?
]{
Returns the first value in the environment.
}

@defproc[
  (get-index-env
    [ anInt integer? ]
    [ anEnv extend-env? ]
  )
  value?
]{
Returns the anInt-th value in the environment.
}
