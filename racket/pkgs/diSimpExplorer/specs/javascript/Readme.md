# diSimpExplorer (javascript) specifications

This directory collects the unit, integration and functional 
specifications for the javascript implementation of the diSimpExplorer 
[Zepto.js](http://zeptojs.com/) browser controls.

We use the [Jasmine.js 
v2.4](http://jasmine.github.io/2.4/introduction.html) 
[BDD](https://en.wikipedia.org/wiki/Behavior-driven_development) 
framework.

To use the Jasmine.js framework you need [node.js and npm 
installed](https://nodejs.org/en/). You then need to install Jasmine.js 
globally by typing:

> sudo npm install -g jasmine

You then need to install the Jasmine.js framework locally. In the 
specs/javascript directory, type:

> npm install jasmine

this will create the node_modules/jasmine directory. Then type:

> jasmine init

this will create the spec/support directory required by the jasmine 
specification framework.
