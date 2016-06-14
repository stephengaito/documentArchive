# Sprint 001 initial foundations

* Started: unknown
* Ends: unknown

## Problem

Our overall "story" is that computation is equivalent to ZFC. Current 
definitions of computation are limited to countable computational 
devices. Clearly to recover the *whole* of ZFC, we need to assume 
something more than countable computational devices.  When we get there, 
we will only have to make two addition assumptions: directed limits exist 
and, for any computational device, the co-algebraic component can be 
serialised (by the next more powerful computational device).

## Tasks

* define the List of Lists (LoL) model of computation
  * define the rules of LoL
  * define a sequential computation in LoL
  * define composition of sequential compositions.
  * exhibit a universal Turing machine as a LoL computation
  * show that any LoL computation can be computed by a Turing machine.

* show that composition of computation paths, makes LoL into a category.

* show that LoL actually forms a dual algebraic / co-algebraic pair of 
topos.

* show that sub-topos provide the correct definition of "definition".

* define the concept of interpretations as functors between topos.

* define the topos of ordinals and provide a number of example 
interpretations of the topos of ordinals into the topos of LoL.

...

## Features

## Specifications

## Questions and Risks

How do we exhibit these tasks with out falling into a vicious circle both 
philosophically (by assuming the existence of things we have not yet 
proven to exist), and in practical terms (find an acceptable bootstrapping 
sequence)?

*Our* "compiler" is meant to only successfully compile **if** the text of 
the program it is given is formally correct. In order to "bootstrap" the 
"full" compiler, we need to pass through a number of steps with 
initially simpler compilers compiling slightly more complex compilers 
until we reach a compiler which can compile itself (and hence exhibit its 
own formal correctness). To convince the mathematical community of the 
correctness of this compiler, it also needs to be "easy" for a human to 
review and hence "understand".

A central problem is that the "definition" of formal correctness requires 
the definition of (pre and post) conditions, which in turn requires the 
"definition" of sub-topos, which in turn requires the "definition" of 
assertions, which in turn requires exhibiting that the LoL has the 
standard properties of a category, together with functors, etc...

What is the syntax of a LoL program?

We can define (using denotational, operational and axiomatic semantics), a 
mathematical programming language. We really want this language to be 
functional with first class "functions". This language needs to be Turing 
complete.

We can then follow a chain of bootstrapping steps to go from a purely 
Racket based compiler to a purely mathematical programming language based 
compiler (possibly implemented on Racket's runtime support).


## Resources

* Section 6.9 of [Introduction to Coalgebra. Towards Mathematics of 
States and 
Observations](http://www.cs.ru.nl/B.Jacobs/CLG/JacobsCoalgebraIntro.pdf) 
defines sub-co-algebras, via rules and assertions.

## Wrap-up
