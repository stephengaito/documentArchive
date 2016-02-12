#lang scribble/manual

@require[@for-label[diSimp]]

@title[#:tag "top"]{diSimp}

@author{Stephen Gaito}

@defmodule[diSimp]

The @racketmodname[diSimp] library provides the code to implement the 
diSimplex interpreter.

The ideas for how to implement this interpreter have been adapted from 
@hyperlink["http://www.eopl3.com/"]{Essentials of Programming Languages} 
and both editions of 
@hyperlink["https://cs.brown.edu/~sk/Publications/Books/ProgLangs/2007-04-26/"]{Programming 
Languages: Application and Interpretation}.

The Mathematical and Philosophyical ideas which this interpreter is 
implementing can be found in the companion papers TODO.

@local-table-of-contents[]

@include-section["interpreter.scrbl"]
@include-section["listExps.scrbl"]

