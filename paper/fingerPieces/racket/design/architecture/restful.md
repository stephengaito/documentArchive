**Table of Contents**

  - [diSimpExplorer's RESTful communication between the front and back ends](#disimpexplorer-s-restful-communication-between-the-front-and-back-ends)
    - [Problem](#problem)
    - [Goals ](#goals-)
    - [Requirements](#requirements)
    - [Solution](#solution)
    - [Questions and Risk](#questions-and-risk)
    - [Resources](#resources)

<!--- END TOC -->

# diSimpExplorer's RESTful communication between the front and back ends

## Problem

The diSimpExplorer uses a standard modern web browser as its graphical 
user interface "frontend". In particular this enables the eventual use of 
[MathJAX](http://www.mathjax.org/) to display simple mathematical 
notation.

The diSimpExplorer is also performing a task on behalf of the user which 
is both too large and complex to be performed in a browser as well as 
more naturally performed in LISP/Racket rather than Javascript.

This means that we have chosen to architect the diSimpExplorer tool as a 
browser based frontend communicating with a Racket based backend 
web-server. 

This implies that communication between the front and back ends will be 
naturally be via TCP/IP (via a IP-port on (at least) the localhost).

## Goals 

At the moment, we *prefer* that all communication be as simple as possible 
and in particular be 
[RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer).

## Requirements

> The diSimpExplorer web-server SHOULD have a RESTful interface

## Solution

We make use of the [dmac/spin](https://github.com/dmac/spin) project, and 
in particular [our modifications](https://github.com/stephengaito/spin) 
(currently found on the "adding-binary-servlets" branch).

## Questions and Risk

## Resources