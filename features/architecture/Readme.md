**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [FandianPF (integration) architecture](#fandianpf-integration-architecture)
	- [Problem: Scalable deployment](#problem-scalable-deployment)
		- [Goals](#goals)
			- [Requirements](#requirements)
	- [Problem: Semi-structured datastore](#problem-semi-structured-datastore)
		- [Goals](#goals-1)
			- [Requirements](#requirements-1)
	- [Problem: User authentication](#problem-user-authentication)
		- [Goals](#goals-2)
			- [Requirements](#requirements-2)
	- [Problem: Administrative interfaces.](#problem-administrative-interfaces)
		- [Goals](#goals-3)
			- [Requirements](#requirements-3)
	- [Problem: Secure access](#problem-secure-access)
		- [Goals](#goals-4)
			- [Requirements](#requirements-4)
	- [Problem: WebApp security](#problem-webapp-security)
		- [Goals](#goals-5)
			- [Requirements](#requirements-5)
	- [Problem: Agile open source development](#problem-agile-open-source-development)
		- [Goals](#goals-6)
			- [Requirements](#requirements-6)

# FandianPF (integration) architecture

## Problem: Scalable deployment

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

> It SHOULD be possible to deploy on Heroku

> It MIGHT be possible to deploy as a Google App.

## Problem: Semi-structured datastore

The structure of references in standard reference databases (such as 
BibTeX and/or Zotero) do not have a fixed structure, since different 
types of references have different fields.  Moreover the list of 
reference types is effectively open-ended.

Once we accept the need for semi-structured data, the other types of 
data which can usefully be semi-structured is really quite large: 
issues, ...

Some of the data we want to be able to capture, such as "decorations" 
on existing content, can usefully have fairly rigid structure. Examples 
of such decorations are, versions, draft-quality, level-of-detail, ...

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

## Problem: User authentication

In any long lived system which will accumulate a large amount of 
valuable data, there is a need for various different users to maintain 
different aspects of the system.

We need to ensure different users, with differing roles, have 
appropriate levels of access to modify the system.

### Goals

Provide flexible user accounts based upon the OpenID standard.

#### Requirements

> There SHOULD be different levels of "users" consisting (but not 
> necessarily limited to): "Administrators", "Editors", "Authors", 
> "Commenters", "Readers", "Spammers"(!?). 

> These different "users" WILL have differing levels of access to 
> access or alter content or otherwise control the contents of the 
> system.

> Administrators, Editors, and Authors MUST be identified to the system 
> with an "account".

> Commenters MIGHT be allowed to leave a comment by only using an (one 
> off) OpenID to identify themselves.

> Commenters NEED NOT have an account on a given FandianPF instance.

> Readers MIGHT not need to identify themselves.

> There MIGHT be a list of blocked Spammers.

> It MUST be possible to link accounts between different instances of 
> FandianPF.

> Local accounts MIGHT be "externalised" to other FandianPF instances 
> by making FandianPF an OpenID provider.

> Users on one instance of FandianPF need not have the same privileges 
> on a linked instance of FandianPF.

> The quality of an OpenID provider known to a FandianPF instance 
> SHOULD be ranked. 

> This OpenID provider ranking MIGHT be used in filtering spam.

> This OpenID provider ranking MIGHT be used in user authentication.

## Problem: Administrative interfaces.

Balancing the twin goals of making administration of a FandianPF 
instance both easy and secure will be an interesting challenge.

Web-interfaces will probably be the most natural admin interface for 
private FandianPF instances used by either a single researcher or a 
small team on a secure VPN.

Configuration files or command line interfaces would probably be the 
most secure way to administer a highly public FandianPF interface.

### Goals

Provide a set of flexible *and* secure administrative interfaces.

#### Requirements

> Administration of an individual FandianPF instance SHOULD be easy.

> The administration of highly public FandianPF instances MUST be 
> secure.

> The administrator SHOULD have the ability to turn on or off web-based 
> administration.

> There MIGHT be command line tools to effect administration.  
> *Question:* How will administrators administer Heroku-like 
> instances without a web-interface?

> The administrator MUST be able to configure, initialise, dump, clear, 
> and upgrade the (contents of the) datastore.

> The administrator MUST be able to add users and assign them various 
> roles.

> The administrator MUST be able to configure (user) trust 
> relationships between FandianPF instances.

> The administrator MUST be able to configure (data) trust 
> relationships between FandianPF instances.

> Use of configuration files (if any) MUST not prohibit a Heroku or 
> Google App type of deployment.

> Use of command line tools (if any) MUST not prohibit a Heroku or 
> Google App type of deployment.

## Problem: Secure access

Current secure communication technologies vary in their ease of use.

For our purposes the most secure communication technologies are HTTPS 
(HTTP over SSL/TLS).  HTTPS can, today, optionally require clients to 
supply a client certificate.  By requiring both the standard server and 
the rarely used client certificates in the HTTPS protocol, we ensure 
there is a very low probability of a "agent in the middle attack" (that 
is, there is no agent in the middle who is listening to the 
communication). We also raise the confidence that the client is who 
they say they are.

Again, for our purposes, another secure communication technology is VPN 
(virtual private networks).  If a FandianPF instance is bound 
exclusively to VPN interfaces, then it should be assumed that all 
communication is secure (enough).

Finally for easy use by one user (a very typical use case), we should 
assume that a FandianPF instance which is bound exclusively to the 
localhost loopback interface (127.0.0.1) is secure (enough).

### Goals

Allow a range of secure (enough) communication channels.

Allow different user roles to use communication channels with different 
levels of security.

#### Requirements

> It MUST be possible to use HTTPS (with server certificates) (HTTPS).

> It MUST be possible to use HTTPS with BOTH client and server 
> certificates (HTTPSC).

> It MUST be possible to configure an instance to allow the use of any 
> of HTTP, HTTPS, or HTTPSC on any particular route.

> User roles who are "just" reading the content, SHOULD not need to use 
> HTTPSC or VPN communication channels.

> It SHOULD be possible to run "our own" highly secure (HTTPSC) OpenID 
> server.

> It MIGHT be possible to have "our own" highly secure OpenID server 
> require multiple types of credentials.

> It MUST be possible to override all HTTPS or HTTPSC requirements IF 
> the FandianPF instance is bound exclusively to the 127.0.0.1 
> (localhost loopback) interface.

> It MUST be possible to override all HTTPS or HTTPSC requirements IF 
> the FandianPF instance is bound exclusively to VPN secured 
> interfaces.

## Problem: WebApp security

Like it or not, there are people out there who will try to break any 
security systems we might put in place to control access to a FandianPF 
instance. This will be a significant problem for any highly public web 
application.

While we do not want to become so paranoid that the application becomes 
impossible for normal use, we *do* want to ensure all of the obvious 
vulnerabilities are protected against.

### Goals

Ensure any FandianPF instance is as difficult to hack as feasibly 
possible.

#### Requirements

> ALL user input MUST be scanned for malicious intent.

> Consider using Rack middleware to scan all inbound requests for 
> security violations.

## Problem: Agile open source development

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

