#lang scribble/manual

@(require "utils.rkt")

@title[#:tag "top"]{RacketLayer}
@(author-stg)

@defmodule[racketLayer]

The @racketmodname[racketLayer] library provides a clean interface to the
underlying Racket language/engine. We use it to ensure we have controlled
access to the symbols/methods which are allowed to be used in the
overlying diSimp language.

The default racketLayer is intended to be very minimal. Future
optimisation can be enabled by require'ing additional capabilities using
racketLayer/xxxx modules.

@local-table-of-contents[]

