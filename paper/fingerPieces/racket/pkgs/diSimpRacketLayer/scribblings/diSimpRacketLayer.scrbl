#lang scribble/manual

@(require "utils.rkt")
@(require (for-label racket/base ))

@title[#:tag "top"]{diSimpRacketLayer}
@(author-stg)

@defmodule[diSimpRacketLayer]

The @racketmodname[diSimpRacketLayer] library provides a clean 
interface to the underlying Racket language/engine. We use it to ensure 
we have controlled access to the symbols/methods which are allowed to 
be used in the overlying diSimp language.

The default diSimpRacketLayer is intended to be very minimal. Future 
optimisation can be enabled by require'ing additional capabilities 
using diSimpRacketLayer/xxxx modules.

@local-table-of-contents[]

