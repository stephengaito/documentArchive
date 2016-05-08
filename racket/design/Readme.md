# Problem

Mathematics is the subtle interplay between language interpretation and 
language rewriting.

A "computation" is a collection of language rewriting steps.

A "computation" which is "proven" to be "correct" is a collection of 
language rewriting steps which when given a language structure 
statisfying a given pre-condition, computes a resulting language 
structure which satisfies a given post-condition, using only either 
axiomatic rewriting rules, or computations which have been previously 
been proven correct.

Our primary objective is to build a cross compiler which will only 
"compile" a computation which is provably correct. If a non-trivial 
language interpretation is provided, then the *cross* compiler compiles 
the computation into a computation of the interpreted language.

The List of Lists language is the simplest possible language which has 
itself as its own semantic interpretation.

# Design goals

We want to build a *simple* collection of computational tools which 
allows us to:

1. denote a computational structure which is provably correct.

2. construct a compuational structure.

3. persist a computational structure.

5. verify the correctness of a computational structure.

6. navigate the category of previously proven correct comutational 
   structures

7. construct an (semantic) interpretation.

8. persist an interpretation.

9. navigate the category of interpretations.

# Tools

1. a basic programmer's text editor to edit flat text files of 
   computational structures.

2. a cross compiler which verifies a compuational structure and cross 
   compiles if the given interpretation is not the identity 
   interpretation.

3. a browser/javascript/frontend + server/racket/persistent-layer pair 
   of tools to graphically navigate the collection of compuational 
   structures and interpretation mappings, which can be used to 
   interactively construct a computational structure or interpretation 
   mapping.
