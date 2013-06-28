**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Sprint 001 building initial scaffolding](#sprint-001-building-initial-scaffolding)
	- [Tasks](#tasks)
	- [Cucumber features](#cucumber-features)
	- [RSpec specifications](#rspec-specifications)
	- [Questions/Risks](#questionsrisks)
		- [DRY Cucumber Scenerioes?](#dry-cucumber-scenerioes)
		- [RESTful development:](#restful-development)
			- [Browser support](#browser-support)
			- [Test integration](#test-integration)
			- [Command line support](#command-line-support)
			- [Browser in-place-editing](#browser-in-place-editing)
		- [HTML testing](#html-testing)
		- [Markdown tools](#markdown-tools)
	- [Reflections](#reflections)
		- [Learning curves](#learning-curves)

# Sprint 001 building initial scaffolding

 * Started: 2013/06/20 Thursday
 * Completed: 2013/06/28 Friday

## Tasks

 1. determine licences (for documentation and code)
 1. setup bundler
 1. create initial Padrino web application
 1. record additional required dependencies
 1. create *initial* *crude* fandianpf script
 1. run cucumber/rspec loop.... 
 1. create simple (mass) upload/download script (**postponed**)
 1. setup simple markdown documentation tools

## Cucumber features

 1. simpleRESTfulInterface

## RSpec specifications

 1. none at the moment...

## Questions/Risks

### DRY Cucumber Scenerioes? 

At the Cucumber Scenario level we want to remain fairly high-level. At 
the Cucumber Step Definition level we want to equally stay at a 
"medium-level". The RSpec specifications should also be "medium-level". 
Where does the "low-level" expectations/specifications go in a DRY way?

The problem here is that, in "normal" Cucumber/RSpec work, this 
low-level detail can often get "repeated" between both Cucumber Step 
Definitions and RSpec descriptions, since the expectations are often 
placed directly on what are rather ephemeral instances of fairly 
emphemeral objects; instances which are created in rapid fire fashion 
to "test" one expectation.

*How do we write a "specification" for an object or class in one place 
and share it between both Cucumber and RSpec?*

### RESTful development:

There are four aspects

#### Browser support

We use the FireFox addon 
[RestClient](https://addons.mozilla.org/en-us/firefox/addon/restclient/)

#### Test integration

We use [Rack::Test](https://github.com/brynary/rack-test#racktest-) which is already a testing dependency of Padrino

#### Command line support

 1. we could use a simple HTTP interface:

  1. 
[Net::Http](http://ruby-doc.org/stdlib-2.0/libdoc/net/http/rdoc/Net/HTTP.html) 
which is a ruby standard lib.

  1. [Excon](https://github.com/geemus/excon#readme)

  1. [Typhoeus](https://github.com/typhoeus/typhoeus#readme)

  1. [Patron](http://toland.github.com/patron/)

 1. we use [REST Client](https://github.com/rest-client/rest-client#rest-client--simple-dsl-for-accessing-http-and-rest-resources) 
which is a simple DSL for accessing HTTP and REST resources, it has:

  1. very good documentation

  1. nice irb wrapper

  1. stubs via [WebMock](https://github.com/bblimke/webmock#webmock--)

  1. rack-like middle ware using [rest-client-components](https://github.com/crohr/rest-client-components#rest-client-components)

  1. is [used by](https://www.ruby-toolbox.com/projects/rest-client) Chef and Heroku (among many others)

 1. considered [Faraday](https://github.com/lostisland/faraday#faraday) this has 
a rack-like middle ware interface.

 1. considered [httparty](https://github.com/jnunemaker/httparty#httparty)

#### Browser in-place-editing

 1. we use [Best in 
Place](https://github.com/bernat/best_in_place#best-in-place) uses ajax 
out of the box, has been forked from Rest-in-Place, has much better 
documentation, but a rather ugly interface which I guess could be CSS 
skinned.

 1. considered [Rest in 
Place](https://github.com/janv/rest_in_place/#rest-in-place) uses ajax 
out of the box, older, has rather poorer documentation, no obvious 
demo.

 1. considered [JSON editor jQuery 
plugin](https://github.com/DavidDurman/FlexiJsonEditor#json-editor-jquery-plugin) 
does not seem to include ajax components, this would require me to wrap 
my "own", *but* has rather nicer, out of the box, look and feel.

### HTML testing

We are using the 
[Capybara](https://github.com/jnicklas/capybara#capybara) tools using 
either the stanard Rack driver or the 
[Poltergeist](https://github.com/jonleighton/poltergeist#poltergeist---a-phantomjs-driver-for-capybara) 
driver which in turn uses the [PhantomJS](http://phantomjs.org/) 
headless webkit browser.

 1. [Capybara DSL](https://github.com/jnicklas/capybara#the-dsl)

 1. [Capybara Drivers](https://github.com/jnicklas/capybara#drivers)

### Markdown tools

 1. We use 
[redcarpet](https://github.com/vmg/redcarpet#redcarpet-2-is-written-with-sugar-spice-and-everything-nice) 
to preview our Markdown documentation as it seems to be the closest to 
that used by GitHub. *However* its :with_toc_data does *not* behave in 
the same way that GitHub does ;-(

    To use redcarpet type:

    > redcarpet \<-markdown-file-\> > \<-html-file-\>

 1. We use [DocToc](https://github.com/thlorenz/doctoc#doctoc-) to 
create tables of contents at the top of all of our Markdown 
documentation files.

    To use DocToc cd to the root of the project and then type:

    > doctoc .

## Reflections

### Learning curves

Most of this sprint has been taken up learning about the various tools 
used, and/or tripping over "features" which where documented but poorly 
understood by me ;-(
