# Testing

## Problem

The overall collection of diSimplicial tools crosses a number of 
different programming paradigms and tools.

This means we will require a number of different tools to test the full 
end-to-end systems for each tool.

The most complex tool will be the diSimpExplorer which has both user 
interface elements contained in a standard modern browser built using 
javascript, as well as a web-application interface built using Racket.

For any complete tool, for our purposes, there are a number of 
[differing types of 
tests](http://stackoverflow.com/questions/4904096/whats-the-difference-between-unit-functional-acceptance-and-integration-test).

  * **Unit testing** Tests our code at the finest levels, is of primary 
    interest only to the programmers, tests only single functions or 
    objects, and generally run quickly (so can be run often).

    **Unit tests should run quickly and often to catch problems as soon 
    as possible.**

  * **Integration testing** Tests our code at more complex levels, is of 
    primary interest only to the programmers, tests the *integration* 
    between multiple functions or objects, and generally runs very slowly 
    given the amount of state that needs to be setup/torn down for each 
    suite of tests.

    **Integration tests should be showing that complex collections of 
    functions or objects are managing state correctly.**

  * **Functional or Acceptance testing** Tests our code at the complete 
    end-to-end level, is of primary interest to the end users and 
    stackholders, and again generally runs very slowly.

    **Functional tests should be showing that end-user stories are 
    complete.**

## Goals

We want to make maintaining our collection of tests as simple as 
possible so that these tests are both "easy to run" as well as remain 
relevant.

## Requirements

> Each level of testing, unit, integration, and functional, SHOULD have 
> their own command line tool which should run a text based reporter.

> For the purposes of simplicity, functional testing of the 
> diSimpExplorer WILL make use of a browser based runner/reporter.

> Where possible, documentation (coverage) SHOULD also be tested.

> Once a test suite has been started, at the command line or in the 
> browser, there MUST NOT be any user involvement.

## Solution

Each racket package will have three racket scripts, which can each be 
run at the command line, to perform unit, integration and functional 
tests, runUtests, runItests, and runFtests, respectively.

The diSimpExplorer functional tests will run the Racket web-application 
three times one for each of the different browsers:

  * **Firefox/Gecko** (requires no changes)

  * **Chromium-browser/Blink/V8** requires the following code (note the 
    spaces):
    
> (require net/sendurl)
>
> (external-browser (cons "chromium-browser " " "))

  * **Midori/WebKit** requires the following code (note the spaces):

> (require net/sendurl)
>
> (external-browser (cons "midori " " "))

In each case we will use the [Jasmine.js](http://jasmine.github.io/) 
javascript BDD/specification framework. In particular we will use the 
HtmlReporter in the [boot.js 
script](http://jasmine.github.io/2.4/boot.html). For the functional 
testing, the Jasmine based specifications will make use of the [Zepto.js 
trigger](http://zeptojs.com/#trigger) method to trigger user events on 
various elements of the DOM, in ways as similar as possible to an actual 
user interacting with the diSimpExplorer tool.

## Questions and Risks

Function testing of javascript/DOM events in the browser *requires* 
triggering these events by the test scripts themselves, this means that 
we need *either* a javascript framework or javascript testing framework 
which makes *triggering events easy*. This suggests that we use the 
[Zepto.js](http://zeptojs.com/) javascript framework. 

Multiple browsers have different javascript/DOM internals. This means we 
need to find a way to run browser tests in a number of differing 
browsers. At the moment we have access to both the firefox (gecko) and 
chromium (blink/v8) and Midori (webkit) 
[browsers](https://help.ubuntu.com/community/WebBrowsers) 
([javascript/DOM 
implementations](https://en.wikipedia.org/wiki/Comparison_of_layout_engines_%28ECMAScript%29)), 
each with the following [market 
share](https://www.netmarketshare.com/browser-market-share.aspx?qprid=2&qpcustomd=0). 

The major missing javascript/DOM engine/browser is of course Internet 
Explorer, unfortunately for a "Linux only shop" it is prohibitively 
difficult and/or expensive to test this family of browsers. So we won't.

The [Racket Web-appliations](https://docs.racket-lang.org/web-server/) 
all use [net/sendurl](https://docs.racket-lang.org/net/sendurl.html) to 
start a browser by default. We can manipulate the 
'[external-browser](https://docs.racket-lang.org/net/sendurl.html#%28def._%28%28lib._net%2Fsendurl..rkt%29._external-browser%29%29)' 
definition to control which of the above three browsers will be used.


