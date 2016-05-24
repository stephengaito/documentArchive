# diSimpExplorer (javascript) specifications

This directory collects the functional specifications for the javascript 
implementation of the diSimpExplorer [Zepto.js](http://zeptojs.com/) 
browser controls.

**Functional or Acceptance testing** tests our code at the complete 
end-to-end level, is of primary interest to the end users and 
stackholders, and again generally runs very slowly.

**Functional tests should be showing that end-user stories are 
complete.**

We use the [Jasmine.js
v2.4](http://jasmine.github.io/2.4/introduction.html)
[BDD](https://en.wikipedia.org/wiki/Behavior-driven_development)
framework.

In order to simulate user actions we make extensive use of [Zepto.js 
triggers](http://zeptojs.com/#trigger).