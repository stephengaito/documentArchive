#lang scribble/manual

@(require "utils.rkt")
@(require (for-label racket))

@title[#:tag "operators"]{diSimplex interpreter operators}
@(author-stg)

@defmodule[diSimpInterpreter/operators]

The @racketmodname[diSimpInterpreter/operators] module implements the 
diSimplex interpreter operators using the Racket dialect of Scheme/Lisp.

@defproc[
  (noop)
  list?
]{
Returns the noop tag.
}

@defproc[
  (pop)
  list?
]{
Returns the pop tag.
}

@defproc[
  (stack)
  list?
]{
Returns the stack tag.
}

@defproc[
  (unStack)
  list?
]{
Returns the unStack tag.
}

@defproc[
  (newStack)
  list?
]{
Returns the newStack tag.
}

