# FandianPF (integration) architecture

## Problem

We have a requirement to provide RESTful interfaces between a cloud of 
FandianPF systems.

We also have a requirement to allow public access to some or all of the 
content of a given system.

Many users (readers) will only want incidental occasional access.

At the moment, June 2013, the best tool to build a TeX/LaTeX/SVG macro 
filter is ANTLR4.  At the moment, ANTLR4, which is based on Java, does 
not yet have a C++ target, hence in the short to medium term we need to 
use infrastructure based on the Java JVM.

### Goals

We would ideally like an architecture which scales *from* an 
individual's personal "tablet" up to large "cloud" installations.

Incidental users should be able to use the system with out requiring 
overt installation.

Power users should not require complex installation instructions.

We should be able to build the FandianPF system in a "productive" MVC 
based system which can run on multiple platforms.

I know (and love) Ruby...

#### Requirements

> The system WILL provide a standard webserver interfaces.

> The content of the system MUST be browsable and editable in a 
> (modern) standard browser on a variety of platforms (mobile through 
> desktops).

> The system WILL be based on the Ruby language with possible 
> C/C++ and/or Java extensions.

> The system WILL be based upon the Puma/Rack/Sinatra/Padrino webserver 
> stack.

> Tablet installations SHOULD use Ruboto's infrastructure.

> Laptop, Desktop and virtual private server installations SHOULD 
> (eventually) use any of Ruby's MRI, Rubinius, or jRuby platforms 
> (C/C++, C/C++, and Java respectively).

> Cloud installations SHOULD use Java WAR file distribution.

## Problem

The structure of references in standard reference databases (such as 
BibTeX and/or Zotero) do not have a fixed structure, since different 
types of references have different fields.  Moreover the list of 
reference types is effectively open-ended.

Once we accept the need for semi-structured data, the other types of 
data which can usefully be semi-structured is really quite large: 
issues, ...

Some of the data we want to be able to capture, such as "decorations" 
on existing content, can usefully have fairly rigid structure.  
Examples of such decorations are, versions, draft-quality, 
level-of-detail, ...

So there is a need to mix structured and semi-structured data in a 
single data management system.  We take ideas from [Goat 
Fish](https://github.com/stochastic-technologies/goatfish) which stores 
semi-structured JSON data in an Sqlite database.

### Goals

Extensible semi-structured data should be stored in standard databases 
which should not require complex installations but can be scaled from 
the personal tablet to the cloud.

#### Requirements

> The backing store WILL be based upon standard RDBMS databases (such 
> as Sqlite, MySql, PostgreSQL).

> Data objects COULD be extensible semi-structured documents.

> Semi-structured documents MUST be indexable using pre-specified 
> properties in various "duck-typed" collections.

> Semi-structured documents MUST be searchable using ANY property. 
> (Performance on non-pre-indexed properties MIGHT NOT be performant).

> Semi-structured documents WILL be stored as JSON (string - text) 
> objects.

> Structured data should be storable in standard database tables.

## Problem

I need to keep the development of this project simple, lightweight and 
fast.

### Goals

The source code should be open and of continuous high quality.

The project should be developed using Behaviour Driven Development techniques.

#### Requirements

> The source code for the FandianPF system WILL be accessible via GitHub.

> The source code for the FandianPF system WILL be given a non-copyleft 
> open source License.

> The source code WILL be tested using a Continuous Integration server 
> (Travis?).

> The dependencies WILL be tracked using ....

> The code quality WILL be measured using ...

> Integration features WILL be specified and acceptance tested using 
> Cucumber.

> Unit specifications WILL be captured and tested using RSpec.

> Development WILL progress in short "sprints" (of a week or so).

> Each sprint WILL develop a small number of related (Cucumber 
> specified) features.

