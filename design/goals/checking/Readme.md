**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Checking diSimplex proofs](#checking-disimplex-proofs)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Checking diSimplex proofs

## Problem

From a human perspecitve, the main artifact in any diSimplex "proof"
will be the (La)TeX document in which the proof is expressed.

There are essentially two computational times at which a give 
collection of diSimplex proofs can be checked:

1. as the (La)TeX document is being processed,

1. at some time either before or after the (La)TeX document itself has 
been processed.

The checking of a diSimplex proof is definitely *not* easily programmed 
using TeX macros.  However it *is* easily programmed using an 
imperative programming language such as Lua, Ruby, C/C++ or Java. Since 
Lua(La)TeX embedds a Lua interpreter inside (La)TeX, it should be 
feasible for diSimplex proof checking to be preformed while the (La)TeX 
document is being processed, if the checking takes place in Lua/C.

Equally, a Lua/C based checker could be used externally to (La)TeX and 
so *could* happen either before or after the (La)TeX document itself is 
typeset.

One of the primary goals of the FandianPF project, is to ensure that 
rich mathematical ideas can be expressed in a web only environment (in 
addition to a (potential) offline (La)TeX document).

This suggests that it is important that diSimplex proof checking can 
happen on a webserver.  The current most popular webserver languages, 
PHP, Python, Ruby, Java, for programming web-applications can all 
embedd (with more or less difficulty) Lua/C components. This suggests 
that Lua/C is a good choice of implementation language in which to 
program diSimplex proof checking.

Equally importantly, Lua has good parsing support for complex context 
sensitive languages. This support for context sensitive languages, in 
the form of lpeg, is very possibly better than corresponding packages 
in either Ruby, or Java. This means that diSimplex proofs written in a 
web-application, can be checked for syntactical correctness in a 
web-safe way *before* being checked for (proof) validity.

## Goals

Checking diSimplex proofs should be able to be done either before, 
during, or after a (La)TeX document is being processed, and/or by a 
webserver.

## Requirements

> The diSimplexEngine SHOULD be written in a combination of Lua and C 
> code.

> The syntax of a diSimplex proof SHOULD be based upon (La)TeX.

> The syntax of a diSimplex proof MUST be safe to load for an arbitrary 
> (web) server.  So the syntax MUST NOT be simply an internal DSL for 
> some executable programming language.
