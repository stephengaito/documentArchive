# diSimpExplorer (racket) specifications

This directory collects the functional specifications for the racket 
implementation of the diSimpExplorer [Racket 
web-application](https://docs.racket-lang.org/web-server/).

**Functional or Acceptance testing** tests our code at the complete 
end-to-end level, is of primary interest to the end users and 
stackholders, and again generally runs very slowly.

**Functional tests should be showing that end-user stories are 
complete.**

We use the [RackUnit](http://docs.racket-lang.org/rackunit/) testing
framework.

In order to test end-to-end functionality of the web-server, we will make 
extensive use of the [Racket 
HTTP](https://docs.racket-lang.org/web-server/http.html) and [Racket 
XML-expression parsing](https://docs.racket-lang.org/xml/) libraries.