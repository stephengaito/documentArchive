#lang scribble/manual

@(require "utils.rkt")
@(require (for-label racket/base ))

@title[#:tag "top"]{LP4RacketLayer}
@(author-stg)

@defmodule[lp4RacketLayer]

The @racketmodname[lp4RacketLayer] library provides a clean interface to the
underlying Racket language/engine. We use it to ensure we have controlled
access to the symbols/methods which are allowed to be used in the
overlying LambdaPi4Racket languages.

The default lp4RacketLayer is intended to be very minimal. Future
optimisation can be enabled by require'ing additional capabilities using
lp4RacketLayer/xxxx modules.

@local-table-of-contents[]

