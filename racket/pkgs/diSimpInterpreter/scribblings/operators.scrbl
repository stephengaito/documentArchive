#lang scribble/manual

@(require "utils.rkt")
@(require (for-label racket))

@title[#:tag "operators"]{diSimplex interpreter operators}
@(author-stg)

@defmodule[diSimpInterpreter/operators]

The @racketmodname[diSimpInterpreter/operators] module implements the 
diSimplex interpreter operators using the Racket dialect of Scheme/Lisp.

@defproc[
  (noopTag)
  list?
]{
Returns the noop tag.
}

@defproc[
  (popTag)
  list?
]{
Returns the pop tag.
}

@defproc[
  (consTag)
  list?
]{
Returns the cons tag.
}

@defproc[
  (stackTag)
  list?
]{
Returns the stack tag.
}

@defproc[
  (unStackTag)
  list?
]{
Returns the unStack tag.
}

@defproc[
  (newStackTag)
  list?
]{
Returns the newStack tag.
}

