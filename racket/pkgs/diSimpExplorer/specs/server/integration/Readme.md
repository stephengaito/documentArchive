# diSimpExplorer (racket) specifications

This directory collects the integration specifications for the racket 
implementation of the diSimpExplorer [Racket 
web-application](https://docs.racket-lang.org/web-server/).

**Integration testing** tests our code at more complex levels, is of 
primary interest only to the programmers, tests the *integration* between 
multiple functions or objects, and generally runs very slowly given the 
amount of state that needs to be setup/torn down for each suite of tests.

**Integration tests should be showing that complex collections of 
functions or objects are managing state correctly.**

We use the [RackUnit](http://docs.racket-lang.org/rackunit/) testing
framework.