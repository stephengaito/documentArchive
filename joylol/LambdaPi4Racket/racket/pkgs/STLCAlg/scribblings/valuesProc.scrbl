#lang scribble/manual

@(require "utils.rkt")

@(require
  (for-label
    racket
    STLCAlg/namesData
    STLCAlg/termsData
    STLCAlg/valuesData
    STLCAlg/valuesProc
  )
)

@title[#:tag "valuesProc"]{STLCAlg valuesProc}
@(author-stg)

@defmodule[STLCAlg/valuesProc]

The @racketmodname[STLCAlg/valuesProc] module implements the STLCAlg
values proceedures using the Racket dialect of Scheme/Lisp.

@defproc[
  (value-free
    [ aName name? ]
  )
  value?
]{
Returns a vNeutral value of the nFree-neutral given by aName.
}

@defproc[
  (value-app
    [ aFuncValue vlam-value? ]
    [ anArgValue value? ]
  )
  value?
]{
Returns the application of anArgValue to aFuncValue.
}

@defproc[
  (lp-eval
    [ aTerm term? ]
    [ anEnv env? ]
  )
  value?
]{
Returns the result of lp-evaluating the term aTerm in the environment anEnv.
}
