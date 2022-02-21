# LambdaPi4Racket

This project is a simple port and extension of the existing 
[LambdaPi](https://www.andres-loeh.de/LambdaPi/) Haskell code which is 
the executable part of Andres Löh, Conor McBride and Wouter Swierstra's 
paper ["A Tutorial Implementation of a Dependently Typed Lambda 
Calculus"](https://www.andres-loeh.de/LambdaPi/LambdaPi.pdf)

Our Racket/Scheme/Lisp port of this code is part of our exploration of 
how to write a minimal dependently typed Lambda Calculus in Pure LISP. 
Which is, in turn, part of our exploration of how to provide a 
Computational Foundations for Mathematics.

This project provides three primary subdirectories:

1. **tex** contains the LaTeX sources of a discussion of the semantics 
associated with each of the LambdaPi variants.

2. **haskell/LambdaPi** contains the patches and instructions required to 
get the original LambdaPi Haskell code running using GHC 7.10.3 (from 
early 2016). For more details see the Readme in the haskkell/LambdaPi 
directory.

3. **racket** contains Racket ports of our various variations of the 
LambdaPi code.

The original LambdaPi project explored the Simply-Typed and 
Dependently-Typed variants of the strict Lambda Calculus. Our primary aim 
is to explore the Dependently-Typed "lazy" Lambda Calculus. As part of 
this process we will develop four variants:

1. **STLCAlg** contains the Algebraic Simply-Typed Lambda Calculus in 
which functional application uses call-by-value semantics.

2. **DTLCAlg** contains the Algebraic Dependently-Typed Lambda Calculus 
in which the functional application uses call-by-value semantics.

3. **STLCCoAlg** contains the Co-Algebraic Simply-Typed Lambda Calculus 
in which the functional application uses 
call-by-name/call-by-need/continuation semantics.

4. **DTLCCoAlg** contains the Co-Algebraic Dependently-Typed Lambda 
Calculus in which the functional application uses 
call-by-name/call-by-need/continuation semantics.

