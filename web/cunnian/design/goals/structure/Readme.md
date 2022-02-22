**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Structure of diSimplex artifacts](#structure-of-disimplex-artifacts)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Structure of diSimplex artifacts

## Problem

From a human perspecitve, the main artifact in any diSimplex "proof"
will be the (La)TeX document in which the proof is expressed.

The diSimplex proof language in some sense is a general programming 
language.  Many (interpretive) programming languages allow 
"monkey-patching" and/or otherwise altering definitions/classes outside 
of their original defintion.

We take a conservative (mathematical) attitude that once defined, a 
given defintional object must be closed.  Alternatively adding new 
aspects to an existing defintional or proof object, really represents a 
new defintion or proof.

This attitude greatly simplifies a (human) mathematician's 
understanding of what depends upon what, and hence avoids circular 
definitions and proofs.

A diSimplex proof 

## Goals

## Requirements

> It MUST be syntactically obvious what constitues a diSimplex 
> definition or proof object.

> diSimplex definition or proof objects MUST either provide or inherit 
> the following information:
>
> * version/revision 
> * checking date
> * authour 
> * description 
> * keywords 
> * classification code 
> * depends upon dependencies 
> * conflicts relationships

