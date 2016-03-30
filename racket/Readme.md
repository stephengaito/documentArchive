# Overview

We are targeting the LetRec language in 
friedmanWand2008essentialsProgrammingLanguages

We will use expressions based upon the list operators: cons, car, cdr

The lp4RacketLayer is designed to provide explicit and strict control over 
which elements of the underlying Racket language and engine can use 
(re)used in the LambdaPi4Racket languages.

The default lp4RacketLayer is intended to be very minimal. Future 
optimisation can be enabled by requireing additional capabilities using 
lp4RacketLayer/xxxx modules.

# Notes for later

## LaTeX document generation.

With the standard scribble generation of latex documents a single 
stand-alone LaTeX document is generated. Unfortunately our use case is to 
embed the STLCAlg/STLCCoAlg/DTLCAlg/DTLCCoAlg/lp4RacketLayer scribble 
documents into other LaTeX documents we actually need to remove most of 
the LaTeX definitions.

We can do this by using the scribble --latex-section <n> command. 
