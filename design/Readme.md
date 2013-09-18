**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Overview of design process](#overview-of-design-process)
- [Organisation of the design artefacts](#organisation-of-the-design-artefacts)
- [Thanks](#thanks)
- [ToDo](#todo)

# Overview of design process

We use a Behavioural Driven Development 
([BDD](http://en.wikipedia.org/wiki/Behavior-driven_development)) 
paradigm. A good introduction to BDD can be found in the "[The RSpec 
Book](http://pragprog.com/book/achbd/the-rspec-book)".

The RSpec book champions the use of a two cycle development process. 
The outer (external behaviour) and inner (implementation behaviour) 
developmental cycles.

This process starts by specifying the external behaviour of the 
application by writing (testable) RSpec specifications for this 
behaviour. Once these external specifications fail due to an 
"implementation level" problem we drop down to the inner or 
implementation level cycle and write some RSpec specifications as we 
develop our understanding of the implementation level details.

I am an ardent believer in the usefulness of RSpec.  RSpec is all about 
writing *testable* (behavioural) **specifications**.  The most 
important word here is (behavioural) "specification" (which happen to 
also be testable).  The RSpec specifications should not be tests which 
happen to provide a cobbled together "specification" (after the fact). 
The *behavioural* specification comes first and foremost.

I am also an ardent believer in the use of Yardoc to expose a 
consistent documentation of the code.  We use yard-rspec to ensure the 
RSpec specifications are an integral part of the code documentation.

While the RSpec book champions the use of Cucumber, for various reasons 
we do not use Cucumber.  Instead we use RSpec together with the 
non-Cucumber parts of Aruba and Capybara to test the external behaviour 
of our application.  We keep to Cucumber Gherkin's use of the words 
"feature" and "scenario", since the external behaviour of our 
application are "features" which are used in various ways 
("scenarios").  We may or may not use the Cucumber Gherkin words 
"Given", "When", "Then".

One of the short comings, in my use of Cucumber, was that I was seeing 
the features as a bag of things, and not as a coherent model of the 
external behaviour of the application. To deal with this I believe, 
there is a need for an model of the overall system in which the 
application is used as a part.  This external model should have objects 
corresponding to the primary users, deployment platforms, and "things" 
the primary users see as important.  This external model will have many 
of the aspects of a proper domain model.  However the external model's 
domain objects (which will be repeated in the internal/implementation 
model) will effectively capture the end user's expectations of these 
notional object's external behaviour (and not the internal behaviour 
required to **implement** the application).

To be as Agile as possible we use (roughly) [weekly sprint 
cycles](sprints/Readme.md).

# Organisation of the design artefacts

All RSpec specifications are contained in files whose name ends in 
"Spec.rb".

The RSpec specifications which specify the features of the external 
behaviour are located in the design/features directory.

A discussion of the problems, goals, requirements and (high-level) 
solutions to the design of the external behaviour of the application 
will be found in appropriate Markdown files (*.md) located in 
(sub)directories of the design/features directory.

The RSpec specifications which specify the internal or implementation 
behaviour are located in an appropriate subdirectory of the design 
directory.

The details of each sprint plan will be found in the "sprints" 
directory.

Finally, arbitrary Ruby files found under the design directory are 
either implementations of the external behavioural model, or support 
for the actual RSpec testing infrastructure.

# Thanks

While I have been for a while dissatisfied by my use of Cucumber's 
feature specifications, and felt a need for what I am now calling an 
"external behavioural model", it was 
[nu7hatch](https://github.com/nu7hatch)'s [Nothing really 
matters](http://areyoufuckingcoding.me/2012/03/25/nothing-really-matters/) 
post that "kicked" me into changing things.  While this post is 
provocative, nu7hatch has good things to say.

[Steve Klabnik](http://steveklabnik.com/)'s post [BDD with Rspec and 
Steak](http://timelessrepo.com/bdd-with-rspec-and-steak) provides a 
good example of the use of RSpec specifications for external behaviour.

We will try to use the [Better Specs](http://betterspecs.org/) examples 
to improve our RSpec specifications.

# ToDo

Consider using SimpleCov to look at "test"/"specification" coverage.

Use Dependency Injection to allow mocking of Ruby Classes and/or Ruby 
scripts.
