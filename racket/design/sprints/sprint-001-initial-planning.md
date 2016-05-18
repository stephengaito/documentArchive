**Table of Contents**

  - [Sprint 001 initial planning](#sprint-001-initial-planning)
    - [Problem](#problem)
    - [Tasks](#tasks)
    - [Features](#features)
    - [Specifications](#specifications)
    - [Questions and Risks](#questions-and-risks)
    - [Resources](#resources)
    - [Wrap-up](#wrap-up)

<!--- END TOC -->

# Sprint 001 initial planning

* Started: 2016/05/09
* Extended: 2016/05/13
* Ends: 2016/05/20 Friday
* Completed: 2016/05/18 (early)

## Problem

We are designing a heavily data driven tool suite. The whole idea is that 
we can specify languages and define computation in terms of rewriting of 
the ASTs of these languages.

One of the key issues of a data driven system is that its driving data 
gets complex very quickly. This suggests a tool to visualise and navigate 
this collection of data is important.

**Risk** As mathematicians and scientists we *need* languages which are 
precise, as humans we *like* languages which are ambiguous and 
context-sensitive. What level of context-sensitivity is sufficient to 
make a language humanly easy to work with, without compromising 
precision.

## Tasks

* build a simple frontend/backend using Angular2/Racket (completed)

* Be able to specify a language syntax (pushed)
 * Be able to specify a language syntax (pushed)
 * Be able to specify language axioms (pushed)

* Build a simple tool to read a context-free description of an AST and 
  compile it into a collection of Racket structures. (pushed)

* Load a language artefact (pushed)

* Be able to write out a simple computational "proof" (pushed)

* Rudimentary verification of a simple "proof" (pushed)

All of the above are to be as simple as possible using flat Racket/text files.

## Features

## Specifications

## Questions and Risks

* Need to agree/document file formats for
 * language syntax
 * language axioms
 * computational "proofs"

* How are these files formats "implemented"/recognised/interpreted in the 
tool set?

* How are the persistent forms of the above file formats organised?

* We will eventually build a user interactive tool which is likely to 
comprise a web/javascript based frontend coupled with a Racket 
server/backend. This means that we have to find a transport medium which 
allows the complexity of a language structure to be transferred back and 
forth between the front and backends.

  * We have experimented with using the obvious JSON (wire) format but 
    this does not allow, for example, Racket symbols to be reliably 
    transferred.

  * We have experimented with using LISP/Racket S-expressions. Using code 
    extracted from some MIT licensed code 
    ([littlelisp](https://github.com/maryrosecook/littlelisp)) we can 
    very reliably transfer S-expressions and have a great deal of control 
    over how they are transcribed into javascript.

  * Unfortunately the littlelisp parsing code is *at least* 20 times 
    (~1000 parses per second) slower than the native JSON parsing code 
    (~20000 parses per second). However the frontend/backend based tool 
    is a *user integration* tool, so a significantly sub-second hit per 
    user request is probably very easily tolerated.

## Resources

* [Racket documentation](https://docs.racket-lang.org/)

* [Racket web applications](https://docs.racket-lang.org/web-server/)

* [Racket web continuation 
tutorial](https://docs.racket-lang.org/continue/)

* [Mozilla simulate 
events](https://developer.mozilla.org/samples/domref/dispatchEvent.html) 
[Mozilla 
events](https://developer.mozilla.org/en-US/docs/Web/Guide/Events/Creating_and_triggering_events) 
[triggering events](http://www.2ality.com/2013/06/triggering-events.html)

* [Chai assertion Library](http://chaijs.com/)

* [Jasmine test framework](http://jasmine.github.io/)

* [Plain JS -- examples](https://plainjs.com/)

* 
[Html5Test](http://html5test.com/compare/browser/ie-10/chrome-44/firefox-40.html)

* [GitHub:Fetch](https://github.com/github/fetch) 
[Std:Fetch](https://fetch.spec.whatwg.org/)

* [CSS selectors](http://www.w3schools.com/cssref/css_selectors.asp)

* [ContextMenuJS](http://www.w3schools.com/cssref/css_selectors.asp)

* [Std:XMLHttpRequest](https://xhr.spec.whatwg.org/)

* [Std:DOM](https://dom.spec.whatwg.org/)

* [Light Weight jQuery alternatives](https://dom.spec.whatwg.org/) 
[Zepto.js](http://zeptojs.com/) 
[$dom](https://github.com/julienw/dollardom/)

* [JavaScript Tutorial](http://htmldog.com/guides/javascript/)



## Wrap-up

* Once a very simple angular v2.0 web application was built I noticed the 
  very large/complex number of javascript files required in order to use 
  Angular2. It (as well as its documentation site which I assume is built 
  using Angular2) are very slow.

* In particular, after working through the Angular2 tutorials, I realised 
  the deep miss-match between the Angular WAY of doing things and what the 
  diSimpExplorer tool needs to do.  Angular (as do most of the single page 
  application tools) assumes that the back end is "*simply*" a collection 
  of tables (aka a database). 

  While this is reasonable for most web-applications, this is NOT true for 
  the diSimpExplorer tool. Our tool has much more complex backend 
  processing (and fairly trivial frontend display).

  More to the point the HTML formating *should* largely take place in one 
  place and a natural place for that is the backend. The Angular2
  alternative would have required multiple layers of S-expression 
  translations to/from JSON. With simple HTML processing in the backend, 
  these layers collapse into essentially one and then we use the frontend 
  browser's native HTML parser (or occasionally its JSON parser) for the 
  simple display.

* I am now considering a simpler frontend which uses AJAX to call back 
  and forth to the backend using the Zepto.js framework, to provide 
  core-selection/processing, AJAX (using both HTML/DOM and JSON), and 
  events.

* Now that the frontend/backend framework rationale has been identified, 
  I moved onto specifying a testing framework which could work reasonably 
  simply between the front and back ends, and with both Racket and 
  JavaScript code.

* Finally I have managed to *begin* the process of identifying 
  persistence formats. These format tasks **have NOT been completed** but 
  have been pushed to the next sprint.

* With the results of this sprint, the next sprint can be much more 
  heavily BDD specification driven, and incremental.

* Since the greatest risk is still the frontend/backend based 
  diSimpExplorer tool, the next sprint SHOULD focus on building capability 
  driven by simple diSimpExplorer tool stories.