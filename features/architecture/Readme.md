**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [FandianPF (integration) architecture](#fandianpf-integration-architecture)
	- [Overview](#overview)
	- [Agile open source development](#agile-open-source-development)
		- [Problem](#problem)
		- [Goals](#goals)
		- [Requirements](#requirements)
		- [Solution aspects](#solution-aspects)
			- [Cucumber](#cucumber)
				- [Aruda step definitions](#aruda-step-definitions)
				- [Tags](#tags)

# FandianPF (integration) architecture

## Overview

We split the description of the integration architecture and the 
associated cucumber features into the following areas (one directory 
for each area):

 1. [Administrative interfaces](adminInterfaces)
 1. [Authentication](authentication)
 1. [Data Store](dataStore)
 1. [Deployment](deployment)
 1. [Secure Communication](secureCommunication)
 1. [Web Application Security](webAppSecurity)

The rest of this architectural readme looks at the more general problem 
of organising the development of the project.
 
## Agile open source development

### Problem

I need to keep the development of this project simple, lightweight and 
fast.

### Goals

The source code should be open and of continuous high quality.

The project should be developed using Behaviour Driven Development techniques.

### Requirements

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

### Solution aspects

#### Cucumber

##### Aruda 

We use [cucumber/aruda](https://github.com/cucumber/aruba) to provide 
integration testing of external files, directory structures or command 
line process output.

To [use aruda](https://github.com/cucumber/aruba#usage) put

 > require 'aruba/cucumber'

in support/env.rb

There is a selection of standard [aruda step 
definitions](https://github.com/cucumber/aruba/blob/master/lib/aruba/cucumber.rb) 
which should be used for most integration testing tasks.

##### Tags

The following [cucumber 
tags](https://github.com/cucumber/cucumber/wiki/Tags) are used to 
organise the integration feature testing:

 1. @tbt "To be tested" Any feature tagged with @tbt is currently under 
active development and testing. This tag is meant to be temporary, only 
to be used while active development of this aspect of the project is 
being done.  

 1. [@wip "Work in 
progress"](https://github.com/cucumber/cucumber/wiki/Tags#tag-limits-and-wip) 
Any feature tagged with @wip is currently pending development.  This is 
a standard Cucumber tag which is by default used to ignore any feature 
with this tag.

