#lang scribble/manual

@(require STLCAlg/termsData
          STLCAlg/typesData
          "utils.rkt")
@(require (for-label racket STLCAlg/termsData STLCAlg/typesData))

@title[#:tag "termsData"]{STLCAlg termsData}
@(author-stg)

@defmodule[STLCAlg/termsData]

The @racketmodname[STLCAlg/termsData] module implements the STLCAlg 
terms data structures using the Racket dialect of Scheme/Lisp.

@defproc[
  (term? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a term.
}

@defproc[
  (inf-term? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an inferable term.
}

@defproc[
  (chk-term? 
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an checkable term.
}

@defproc[
  (ann-term?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an annotation term.
}

@defproc[
  (ann-term
    [ aTerm chk-term? ]
    [ aType type? ]
  )
  ann-term?
]{
Returns an annotation term.
}

@defproc[
  (ann-term-term
    [ aTerm ann-term? ]
  )
  chk-term?
]{
Returns the term which has been annotated.
}

@defproc[
  (ann-term-type
    [ aTerm ann-term? ]
  )
  type?
]{
Returns the term which has been annotated.
}

@defproc[
  (bnd-term?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a bound term.
}

@defproc[
  (bnd-term
    [ anInt number? ]
  )
  bnd-term?
]{
Returns a (locally) bound term using a de Bruijn index.
}

@defproc[
  (bnd-term-index
    [ aBoundTerm bnd-term? ]
  )
  number?
]{
Returns the de Bruijn index of this bound term. Undefined otherwise.
}

@defproc[
  (free-term?
    [ someThing any ]
  )
  boolean?
]{
Returns a true if someThing is a free term.
}

@defproc[
  (free-term 
    [ aVarName name? ]
  )
  free-term?
]{
Returns a free term.
}

@defproc[
  (free-term-name
    [ aFreeTerm free-term? ]
  )
  name?
]{
Returns the name of this free term.
}


@defproc[
  (app-term?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is an application term.
}

@defproc[
  (app-term
    [ aFunctionTerm  inf-term? ]
    [ anArgumentTerm chk-term? ]
  )
  app-term?
]{
Returns an application term.
}

@defproc[
  (app-term-func
    [ anApplicationTerm  app-term? ]
  )
  inf-term?
]{
Returns the function term from the application.
}

@defproc[
  (app-term-arg
    [ anApplicationTerm  app-term? ]
  )
  chk-term?
]{
Returns the argument term from the application.
}

@defproc[
  (lam-term?
    [ someThing any ]
  )
  boolean?
]{
Returns true if someThing is a lambda term.
}

@defproc[
  (lam-term
    [ aTerm chk-term? ]
  )
  lam-term?
]{
Returns a lambda term.
}

@defproc[
  (lam-term-term
    [ aLambdaTerm lam-term? ]
  )
  chk-term?
]{
Returns the term bound by this lambda.
}
