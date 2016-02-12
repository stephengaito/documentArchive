#lang scribble/manual

@(require diSimp/listExps
          "utils.rkt")
@(require (for-label racket diSimp/listExps))

@title[#:tag "listExps"]{List Expression data type}
@(author-stg)

@defmodule[diSimp/listExps]

The @racketmodname[diSimp/listExps] module implements the List Expression 
data type for the diSimplex interpreter.

@defproc[
  (list-exp?
    [ listExp list-exp? ]
  )
  boolean?
]{
Returns @racket[#t] if listExp represents a list expression, @racket[#f] 
otherwise.
}

@section{Null/empty list expressions}

@defproc[
  (null-list-exp?
    [ listExp list-exp? ]
  )
  boolean?
]{
Returns @racket[#t] if listExp represents a null list expression, 
@racket[#f] otherwise.
}

@defproc[
  (null-list-exp)
  null-list-exp?
]{
Constructs a null/empty list expression.
}

@section{Cons list expressions}

@defproc[
  (cons-list-exp?
    [ listExp list-exp?]
  )
  boolean?
]{
Returns @racket[#t] if listExp represents a cons list expression, 
@racket[#f] otherwise.
}

@defproc[
  (cons-list-exp
    [ listExp1 list-exp? ]
    [ listExp2 list-exp? ]
  )
  cons-list-exp?
]{
Constructs a cons list expression.
}

@defproc[
  (cons-exp-car
    [ listExp list-exp? ]
  )
  list-exp?
]{
Extracts the first (car) element of the cons list expression.
}

@defproc[
  (cons-exp-cdr
    [ listExp list-exp? ]
  )
  list-exp?
]{
Extracts the second (cdr) element of the cons list expression.
}

@section{Car list expressions}

@defproc[
  (car-list-exp?
    [ listExp list-exp? ]
  )
  boolean?
]{
Returns @racket[#t] if listExp represents a car list expression, 
@racket[#f] otherwise.
}

@defproc[
  (car-list-exp
    [ listExp1 list-exp? ]
  )
  list-exp?
]{
Constructs a car list expression.
}

@defproc[
  (car-exp
    [ listExp car-list-exp? ]
  )
  list-exp?
]{
Extracts the list expression from which the interpreter will extract the 
car element.
}

@section{Cdr list expressions}

@defproc[
  (cdr-list-exp?
    [ listExp list-exp? ]
  )
  boolean?
]{
Returns @racket[#t] if listExp represents a cdr list expression, 
@racket[#f] otherwise.
}

@defproc[
  (cdr-list-exp
    [ listExp1 list-exp? ]
  )
  list-exp?
]{
Constructs a cdr list expression.
}

@defproc[
  (cdr-exp
    [ listExp cdr-list-exp? ]
  )
  list-exp?
]{
Extracts the list expression from which the interpreter will extract the 
cdr element.
}
