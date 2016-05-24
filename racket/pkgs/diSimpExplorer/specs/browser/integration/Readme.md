# diSimpExplorer (javascript) specifications

This directory collects the integration specifications for the javascript 
implementation of the diSimpExplorer [Zepto.js](http://zeptojs.com/) 
browser controls.

**Integration testing** tests our code at more complex levels, is of 
primary interest only to the programmers, tests the *integration* between 
multiple functions or objects, and generally runs very slowly given the 
amount of state that needs to be setup/torn down for each suite of tests.

**Integration tests should be showing that complex collections of 
functions or objects are managing state correctly.**

We use the [Jasmine.js
v2.4](http://jasmine.github.io/2.4/introduction.html)
[BDD](https://en.wikipedia.org/wiki/Behavior-driven_development)
framework.