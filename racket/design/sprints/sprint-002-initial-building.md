**Table of Contents**

  - [Sprint 002 initial building](#sprint-002-initial-building)
    - [Problem](#problem)
    - [Tasks](#tasks)
    - [Features](#features)
    - [Specifications](#specifications)
    - [Questions and Risks](#questions-and-risks)
    - [Resources](#resources)
    - [Wrap-up](#wrap-up)

<!--- END TOC -->

# Sprint 002 initial building

* Started: 2016/05/18
* Ends: 2016/05/27 Friday

## Problem

One of the key issues of a data driven system is that its driving data 
gets complex very quickly. This suggests a tool to visualise and navigate 
this collection of data is important.

We are designing a heavily data driven tool suite. The whole idea is that 
we can specify languages and define computation in terms of rewriting of 
the ASTs of these languages.

## Tasks

* setup testing infra-structure which is integrated with the design 
  descriptions.

* build a simple frontend/backend based diSimpExplorer tool using 
  Zepto.js/Racket which allows the user to browse a live collection of 
  languages and language mappings.

* extend the diSimp tool to initialise a diSimp tool workspace in which to 
  save the languages and mappings.

* extend the diSimp tool to setup/install any required diSimpExplorer 
  libraries. (if any are required to be local the the workspace rather 
  than globally located inside the diSimpExplorer package.

## Features

1. [diSimpExplorer browse languages](../../pkgs/diSimpExplorer/specs/browser/functional/browseLanguages.js)

## Specifications

## Questions and Risks

* Need to agree/document file formats for
 * language syntax
 * language axioms
 * computational "proofs"

* How are these files formats "implemented"/recognised/interpreted in the 
tool set?

* How are the persistent forms of the above file formats organised?

## Resources

* [Racket documentation](https://docs.racket-lang.org/)

* [Racket web applications](https://docs.racket-lang.org/web-server/)
  [Racket HTTP servers](http://docs.racket-lang.org/web-server-internal/)

* [Jasmine test framework](http://jasmine.github.io/)

* [Plain JS -- examples](https://plainjs.com/)

* 
[Html5Test](http://html5test.com/compare/browser/ie-10/chrome-44/firefox-40.html)

* [CSS selectors](http://www.w3schools.com/cssref/css_selectors.asp)

* [ContextMenuJS](http://www.w3schools.com/cssref/css_selectors.asp)

* [Std:XMLHttpRequest](https://xhr.spec.whatwg.org/)

* [Std:DOM](https://dom.spec.whatwg.org/)

* [Light Weight jQuery alternatives](https://dom.spec.whatwg.org/) 
[Zepto.js](http://zeptojs.com/) 
[$dom](https://github.com/julienw/dollardom/)

* [JavaScript Tutorial](http://htmldog.com/guides/javascript/)

## Wrap-up

Nothing at the moment
