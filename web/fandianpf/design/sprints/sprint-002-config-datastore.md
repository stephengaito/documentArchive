**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Sprint 002 Configuration and Simple Datastore](#sprint-002-configuration-and-simple-datastore)
	- [Tasks](#tasks)
	- [Cucumber features](#cucumber-features)
	- [RSpec specifications](#rspec-specifications)
	- [Questions and Risks](#questions-and-risks)
	- [Wrap-up](#wrap-up)

# Sprint 002 Configuration and Simple Datastore

 * Started: 2013/06/28 Friday
 * Paused: 2013/07/01 Monday (to review VPS providers, do administrivia 
and travel)
 * Restarted: 2013/07/21 Sunday
 * Progress slowed while sitting with papa
 * Ends: 2013/08/02 Friday
 * Completed: 2013/07/30 Tuesday (early-ish)

## Tasks

 1. adjust configuration/authentication/deployment requirements
 1. investigate user input sanitization
 1. investigate authentication options
 1. investigate deployment options
 1. investigate configuration options
 1. attempt to create Padrino sample_blog application with OpenID and 
OAuth authentication.
 1. run cucumber/RSpec loop...

## Cucumber features

 1. 
[architecture/adminInterface/configDataStore](../features/architecture/adminInterfaces/configDataStore.feature)

## RSpec specifications

 1. [spec/lib/fandianpf/utils/settingsSpec](../spec/lib/fandianpf/utils/settingsSpec.rb)
 1. [spec/lib/fandianpf/utils/databaseSpec](../spec/lib/fandianpf/utils/databaseSpec.rb)


## Questions and Risks

See the refactored [feature/architecture Readmes](../features/architecture)

## Wrap-up

In hindsight these early sprints are really all about qualifying and 
"containing" various risk areas.  Areas, which, I, as stakeholder, don't 
yet understand well enough to have a "story" about how to proceed.

The result of this sprint is that I *do* have a number of potential 
strategies on how to deal with the administrative interfaces, as well 
as authentication, over a number of typical deployment options.

While writing a security event to a database is fairly trivial, I have 
learnt how various different parts of the problem will likely work 
together including:

 1. Cucumber features using Aruba
 1. RSpec specifications
 1. Dealing with command line options, settings taken from filesystem 
files, and or hard-coded defaults.
 1. Likely options for authentication.
 1. How good or bad Padrino's own authentication system might be
 1. The Padrino's boot processes.
 1. And, simply writing a simple "standard" RDBMS record to an SQLite 
file based database.

In all these results are sufficient to close this sprint and open a new 
sprint on the next most worrying risk area.....

