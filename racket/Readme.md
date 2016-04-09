# Overview

We are targeting the LetRec language in 
friedmanWand2008essentialsProgrammingLanguages

We will use expressions based upon the list operators: cons, car, cdr

The racketLayer is designed to provide explicit and strict control over 
which elements of the underlying Racket language and engine can use 
(re)used in the diSimp language.

The default racketLayer is intended to be very minimal. Future 
optimisation can be enabled by requireing additional capabilities using 
racketLayer/xxxx modules.

# Notes for later

## LaTeX document generation.

With the standard scribble generation of latex documents a single 
stand-alone LaTeX document is generated. Unfortunately our use case is to 
embed the diSimp/racketLayer scribble documents into other LaTeX 
documents we actually need to remove most of the LaTeX definitions.

We can do this in one of three different ways:

1. Write racket code (in the utils.rkt module) which removes or 
overwrites the default *.tex files which contain the unwanted LaTeX 
definitions.

2. Write ruby code which scans the generated file, and removes everything 
before the \begin{document}. This would probably be added as part of a 
diSimp build tool sub-command.

3. Use the scribble --latex-section <n> command. Alas this will still 
need post processing to remove any \includes and or overwritting scribble 
created *.tex "style" files.

# References

See: [cola](http://piumarta.com/software/cola/)

