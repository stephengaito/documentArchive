# Sprint 002 Explore Formal Proofs for Joy

* Started: 2016/10/06
* Ends: unknown

## Problem

Explore the use of formal proof methods inside the Joy language.

One particular objective is to identify a super-set of Joy which is 
fully abstract.

## Tasks

## Features

## Specifications

## Questions and Risks

* How much "local" memory is required. For the diSimp language we need 
to use as little as possible.

* Understand the interplay between code and data on the stack.

* Understand how to remove dependence upon ASCII (or *any* characters). 
The core diSimp implementation must only use Lists of Lists.

* Understand how to implement a parallel version of Joy.

## Resources

* [LCF considered as a programming 
language](http://www.sciencedirect.com/science/article/pii/0304397577900445). 
The paper studies connections between denotational and operational 
semantics for a simple programming language based on LCF. It begins with 
the connection between the behaviour of a program and its denotation. It 
turns out that a program denotes ⊥ in any of several possible semantics 
if it does not terminate. From this it follows that if two terms have 
the same denotation in one of these semantics, they have the same 
behaviour in all contexts. The converse fails for all the semantics. 
**If, however, the language is extended to allow certain parallel 
facilities behavioural equivalence does coincide with denotational 
equivalence in one of the semantics considered, which may therefore be 
called “fully abstract”.** Next a connection is given which actually 
determines the semantics up to isomorphism from the behaviour alone. 
Conversely, by allowing further parallel facilities, every r.e. element 
of the fully abstract semantics becomes definable, thus characterising 
the programming language, up to interdefinability, from the set of r.e. 
elements of the domains of the semantics.

## Wrap-up

