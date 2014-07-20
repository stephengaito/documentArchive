**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Cunnian high-level goals](#cunnian-high-level-goals)
	- [Problem](#problem)
		- [Constraints provided by diSimplex](#constraints-provided-by-disimplex)
		- [Constraints provided by FandianPF](#constraints-provided-by-fandianpf)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Cunnian high-level goals

## Problem

Scientific progress is built upon developing testable, useful, 
theories.  None of these theories are ever universally "True", they 
are, at best, usefully *wrong*.  *Wrong* in that there are always 
better, more detailed, theories, but *useful* in that the testable 
*predictions* which the theories provide, give useful *approximations* 
to what we can observe in the "real" world. *Useful* in that we can, 
and often do, produce engineering artifacts, things that do things for 
people, derived from the theory.

Scientific theories are, at best, ***causal models***.  As a 
mathematician, I am very aware at how little we understand, 
*mathematically*, about how to develop and test ***causal mathematical 
models***.  Science is very much harder than Mathematics, because, 
"proving" cuasality from finite observations of the "real" world, is a 
highly non-trivial task.

My ulimate goal in the FandianPF, Cunnian and diSimplex projects, is to 
provide scientists and engineers with tools with which to build, and 
test mathematical causal models.

To do this the FandianPF project is focused upon providing tools to 
help in the *exposition* of Scientific theories, the diSimplex project 
is focused upon providing the tools to *construct* the required 
mathematics, and the Cunnian project is focused upon providing the 
bridge between the two.  As such, the Cunnian project will largely be 
all about developing the (computational) architectural understanding of 
what is needed to bridge the constructive proof of mathematics with the 
exposition of scientific theories.

The diSimplex project has four major aspects.

1. **diSimplexEngine**: Provide the "local" infrastructure to validate 
*a* mathematical "proof".

1. **diSimplexRepository**: Provide the "global" infrastructure to 
*explore* the structure of the "proofs" contained in a mathematical 
theory.

1. **diSimplexTheory**: Provide the mathematical (meta)theory which 
*justifies* any particular implementation of the local and global 
infrastructure of mathematical theories.

1. **"all the rest"**: Provide (at least a sketch of) the theory of 
*mathematical analysis* (which under-pins Mathematical Physics and all 
of the Mathematical Sciences) using diSimplex Type Theory.

The "all the rest" will encompass numerious mathematical (sub)theories, 
such as, for example, the ordinals, the cardinals, partial orders, etc. 
Each of these subtheories will provide building blocks for both the 
diSimplexTheory, as well as the theory of mathematical analysis.

As a bridge between the FandianPF and diSimplex projects, the Cunnian 
project will of necessity place requirements on the other two projects 
which might not be obvious from the point of view of either the 
FandianPF or diSimplex projects individually.

### Constraints provided by diSimplex

Any mature mathematical theory will have a rich collection of 
dependencies between the various definitional and construction objects 
in the theory.  Most mathematical theories will themselves naturally 
depend upon other theories.

Both human and computational users need ways to understand and explore 
these complex inter-dependencies, and in particular that there are no 
circularities.

### Constraints provided by FandianPF

One of the primary constraints imposed upon the implementation of 
diSimplex proof, is that for any sizable mathematical discussion, 
almost all mathematicians will use (La)TeX.

With current mathematical (social) proof, the proofs are "checked" by a 
human reading and understanding the logical structure of a given proof. 
diSimplex proofs can and should be *checked* by computers.  However 
there remains the needs of the human mathematicians to understand how 
and why a given proof "works".  While the computational part of a 
diSimplex proof no longer needs to carry the human understanding 
(though it might still do so), the human mathematicians still need to 
convey this essential understanding.  It is assumed that this 
understanding will be provided in associated (La)TeX documents.

## Goals

The primary goal of the Cunnian project is to provide the architectural 
overview of requirements on the FandianPF and diSimplex projects which 
are essentially external to either of them individually.

## Requirements

> diSimplex proofs MUST be expressible in a (La)TeX format.

> There MUST be a means of declaring or uniquely infering which 
> dependencies will be used in a given (collection of) constructions.

> There MUST be a ***globally unique*** way of specifying an external 
> diSimplex proof object.

> There MUST be a means for a (computational) user to locate and make 
> use of "external" dependencies.

> There MUST be a means for a (human) user to locate and *read* the 
> discussion associated with a given (computational) diSimplex proof.

> There SHOULD be a means for a (human) user to "browse" all known 
> diSimplex proofs and their "external" dependencies.
