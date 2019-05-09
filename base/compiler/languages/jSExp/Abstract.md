---
title: "Implementing the JoyLoL S-Expression sublanguage"
keywords: 
  - foundations
  - computational
release: draft
authors:
  - Gaito, Stephen
---

## Implementing the JoyLoL S-Expression subanguage

In this document we implement the concrete CoAlgebras which define the 
JoyLoL S-Expression sublanguage.

This JoyLoL S-Expression sublanguage provides a dialect of JoyLoL in which 
to write code fragments in a [concatenative 
programming](https://en.wikipedia.org/wiki/Concatenative_programming_language) 
style. 

In this concatenative style, the programmer only has direct access to the 
*top* of the *data* and *process* stacks. However, each of these stacks 
might *(potentially)* be (non-small) *transfinite* Lists of Lists. 

