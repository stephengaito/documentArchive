**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Problem: Scalable deployment](#problem-scalable-deployment)
- [Goals](#goals)
- [Research](#research)
	- [Deployment options](#deployment-options)
		- [Tablet](#tablet)
		- [Standard desktop, Amazon, or VPS instances](#standard-desktop-amazon-or-vps-instances)
		- [Heroku](#heroku)
		- [Google Apps](#google-apps)
- [Requirements](#requirements)

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

## Goals

We would ideally like an architecture which scales *from* an
individual's personal "tablet" up to large "cloud" installations.

Incidental users should be able to use the system with out requiring
overt installation.

Power users should not require complex installation instructions.

We should be able to build the FandianPF system in a "productive" MVC
based system which can run on multiple platforms.

I know (and love) Ruby...

## Research

### Deployment options

#### Tablet

We have already assumed to be using Ruboto deployment. This would
probably preclude command line usage, and SSL interfaces. However it
would probably be bound to the localhost loopback interface for use only
on the tablet... so these restrictions are unlikely to be a problem...
except *possibly* for securing traffic to/from a remote FandianPF
instance.

#### Standard desktop, Amazon, or VPS instances

There should not be any problems with deployment on a desktop, and
Amazon instance or any other VPS like environment.

Except of course making it very very easy to do ;-(

#### Heroku

It looks like anything that we could run locally can be deployed (one
way or another) to Heroku:

 * Using Java you can run [one-off
processe](https://devcenter.heroku.com/articles/run-non-web-java-processes-on-$
so it is potentially possible to make use of command line tools in a
Heroku environment.  Presumably we could use similar techniques using
JRuby.

 * Any Rack application (such as Sinatra or Padrino) can be [natively
deployed to Heroku](https://devcenter.heroku.com/articles/rack) using
just Git.

 * HTTPS can be
[used](https://devcenter.heroku.com/articles/ssl-endpoint). However
there is no mention of client certificates, so HTTPSC (with client
certificates) might be a problem.

 * it is NOT possible to list a Heroku SSL-endpoint in a private VPN.
(OpenVPN is the lightest weight VPN but it requires access to the OS).

#### Google Apps

From the [Google Apps Java Runtime Environment
description](https://developers.google.com/appengine/docs/java/):

 * It looks like only Warbler packaged WAR files can be deployed to
Google Apps.

 * It also looks like NO local files can be written to. So in
particular Sqlite would probably NOT work.

 * Jars can not be signed.

 * There would be NO command line tools.

 * Discussion of how to use HTTPS can be found in the [deployment
descriptor](https://developers.google.com/appengine/docs/java/config/webxml)
and [using custom
domains](https://developers.google.com/appengine/docs/ssl) discussions.
It looks like there is NO provision for client certificates.

 * it is NOT possible to list a Google SSL-endpoint in a private VPN.
(OpenVPN is the lightest weight VPN but it needs access to the OS).

## Requirements

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


