**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Duck type modules](#duck-type-modules)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Duck type modules

## Problem

Given the flexible semi-structured nature of the content types used in 
FandianPF, we need a similarly flexible semi-structured module system 
to allow specialized behaviour to display and or manipulate the various 
content types.

## Goals

Given the MVC structure of the Padrino toolset, the modules should have 
a similar structure. 

While it is possible to eval external code as text, it would be cleaner 
(and possibly more performant) to add each module to the load path, so 
that a module's code becomes part of the overall application code.

## Requirements

> All content types MUST have default behaviour.

> Specific content types MAY have more specific behaviour.

> It MUST be easy to distribute self contained modules to layer on 
> additional behaviour.

> These modules SHOULD be triggered by corresponding (collections) of 
> JSON fields in a given item of content.

> These modules SHOULD be digitally signed to enable automatic 
> distribution channels.

> FandianPF SHOULD act as its own distribution channel.
