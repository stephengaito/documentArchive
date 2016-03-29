#lang scribble/manual

@(require STLCAlg/typesProc
          "utils.rkt")
@(require 
  (for-label
    racket
    STLCAlg/namesData
    STLCAlg/typesData
    STLCAlg/typesCtxData
    STLCAlg/typesProc
    STLCAlg/termsData
    STLCAlg/termsProc
    STLCAlg/valuesData
    STLCAlg/valuesProc
  )
)

@title[#:tag "typesProc"]{STLCAlg typesProc}
@(author-stg)

@defmodule[STLCAlg/typesProc]

The @racketmodname[STLCAlg/typesProc] module implements the STLCAlg 
type checking proceedures using the Racket dialect of Scheme/Lisp.

@defproc[
  (exn-not-a-kind?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is a not-a-kind exception.
}

@defproc[
  (chk-kind
    [ aCtx ctx? ]
    [ aType type? ]
    [ aKind kind? ]
  )
  (or boolean? exn-not-a-kind? exn-name-not-found-in-context?)
]{
Returns true if, in the context aCtx, the type, aType, has kind, aKind. 

Raises the exception, @racket[exn-not-a-kind?], if aType is not aKind in 
the context aCtx.

Raises the exception, @racket[exn-name-not-found-in-context?], if aType 
is not defined in the context aCtx.

}

@defproc[
  (exn-not-a-type?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is a not-a-type exception.
}

@defproc[
  (exn-illegal-application?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is an illegal-application exception.
}

@defproc[
  (exn-not-func-type?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is a not-func-type exception.
}

@defproc[
  (exn-type-mismatch?
    [ anExn exn? ]
  )
  boolean?
]{
Returns true if the exception, anExn, is an type-mismatch exception.
}

@defproc[
  (infer-type
    [ aCtx ctx? ]
    [ aTerm inf-term? ]
  )
  (or type?
    exn-not-a-type?
    exn-illegal-application?
    exn-not-func-type?
    exn-type-mismatch?
    exn-name-not-found-in-context?
  )
]{

Returns the infered type of the term, aTerm.

Raises the @racket[exn-not-a-type?] exception if aTerm is a 
@racket[free-term?] and the associated @racket[free-term-name] is not 
defined in the context, aCtx.

Raises the @racket[exn-illegal-application?] exception if aTerm is an 
@racket[app-term?] and the associated @racket[app-term-func] is not a 
@racket[func-type?].

Raises the @racket[exn-not-func-type?] exception if aTerm is a 
@racket[lam-term?] and the infered type of aTerm is @emph{not} a 
@racket[func-type?].

Raises the @racket[exn-type-mismatch?] exception if aTerm is a 
@racket[lam-term?] and the infered type does not match any 
correspondingly required type.

Raises the @racket[exn-name-not-found-in-context?] exception if during 
the computation of the infered type the @racket[free-term-name] 
associated to a @racket[free-term?] subterm is not defined in the 
context, aCtx.

}

@defproc[
  (infer-rec-type
    [ anInt number? ]
    [ aCtx ctx? ]
    [ aTerm inf-term? ]
  )
  (or type?
    exn-not-a-type?
    exn-illegal-application?
    exn-not-func-type?
    exn-type-mismatch?
    exn-name-not-found-in-context?
  )
]{
The recursive computation of type inference.

Raises the same exceptions as @racket[infer-type].
}

@defproc[
  (chk-rec-type
    [ anInt number? ]
    [ aCtx ctx? ]
    [ aTerm chk-term? ]
    [ aType type? ]
  )
  (or boolean?
    exn-not-a-type?
    exn-illegal-application?
    exn-not-func-type?
    exn-type-mismatch?
    exn-name-not-found-in-context?
  )
]{
Recursively checks that a given term, aTerm, the type, aType.

Raises the same exceptions as @racket[infer-type].
}


