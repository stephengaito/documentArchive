---
title: "Implementing the JoyLoL Register Machine sublanguage"
keywords: 
  - foundations
  - computational
release: draft
authors:
  - Gaito, Stephen
---

## Implementing the JoyLoL Register Machine subLanguage

In this document we implement the concrete CoAlgebras which define the 
JoyLoL Register Machine sublanguage. 

This JoyLoL Register Machine sublangauge provides a dialect of JoyLoL in 
which to write code fragments in an [imperative 
programming](https://en.wikipedia.org/wiki/Imperative_programming) style. 

In this register machine style, the programmer has direct access to a 
*small* number of *typed* variables as well as a *small* randomly 
accessible address space of *small* *variables*. 

