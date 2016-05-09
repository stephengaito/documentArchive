**Table of Contents**

 - [Backus-Naur form tool](#backus-naur-form-tool)
  - [Problem](#problem)
  - [Goals](#goals)
  - [Requirements](#requirements)
  - [Solution](#solution)
  - [Questions and Risks](#questions-and-risks)

<!--- END TOC -->

# Backus-Naur form tool

## Problem

We need a simple way to take a [Backup-Naur 
form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form) and compile 
it into an associated collection of Racket data structures.

## Goals

## Requirements

## Solution

## Questions and Risks

* We could use Racket's native [macro (syntax) expansion 
forms](https://docs.racket-lang.org/guide/macros.html).

 * see [Fear of Macros](http://www.greghendershott.com/fear-of-macros/)

* We could also use Racket's native [structure 
forms](https://docs.racket-lang.org/reference/define-struct.html).

 * can a Racket structure be car/cdr'ed?