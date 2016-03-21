# LambdaPi

This directory provides the patches required to get the existing 
[LambdaPi](https://www.andres-loeh.de/LambdaPi/) Haskell code to work 
with GHC 7.10.3 (or greater)

The [LambdaPi](https://www.andres-loeh.de/LambdaPi/) Haskell code is the 
executable part of Andres Löh, Conor McBride and Wouter Swierstra's paper 
"A Tutorial Implementation of a Dependently Typed Lambda Calculus"

Our Racket/Scheme/Lisp port of this code is part of our exploration of 
how to write a minimal dependently typed Lambda Calculus in Pure LISP.

# To compile LambdaPi

1. The [LambdaPi](https://www.andres-loeh.de/LambdaPi/) Haskell code, 
prelude.lp and Instructions from the 
[LambdaPi](https://www.andres-loeh.de/LambdaPi/) web-page.

2. A modern GHC (we used ghc 7.10.3 from early 2016).

3. The readline cabal package.... to install, type:
> cabal install readline

4. The patched version of the LambdaPi.hs downloaded above, to patch, type:
> patch --strip=1 < LambdaPi_patch

5. ghc --make -o lp LambdaPi.hs



