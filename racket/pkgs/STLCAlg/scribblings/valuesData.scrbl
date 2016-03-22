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

@title[#:tag "values"]{STLCAlg valuesData}
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
    [ aFuncValue value? ]
    [ anArgValue value? ]
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

