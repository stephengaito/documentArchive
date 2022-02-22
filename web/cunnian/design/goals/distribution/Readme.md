**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Distribution of diSimplex artifacts](#distribution-of-disimplex-artifacts)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Distribution of diSimplex artifacts

## Problem

From a human perspecitve, the main artifact in any diSimplex "proof" 
will be the (La)TeX document in which the proof is expressed.

Since the actual checking of diSimplex proofs is likely to be 
programmed in Lua/C code, we have a number of "logical" distribution 
formats:

1. as a CTAN package.

1. as a LuaRock package.

1. as an ArXiv (or ViXra) document.

1. as a Java Ivy package.

1. as a Ruby gem.

Since none of these package systems have sufficient capability to 
*browse* internal/external dependencies. Either the FandianPF or 
diSimplex projects will have to provide a bespoke browsing system. So 
any browsing requirements do not adequately constrain our choice of 
distribution format.

Natively, neither the CTAN nor ArXiv package formats have dependency 
information.

All three of the LuaRock, Java Ivy and Ruby gem package systems 
natively have dependency information.  The LuaRock and Java Ivy servers 
are simply flat file directories. Unfortunately the Ruby gem servers 
are more complex and require a webserver application.

The [LuaRock rockspec](http://luarocks.org/en/Rockspec_format) is a 
specification as a Lua executable (configuration file). The rockspec 
contains string values and table values structured to contain the 
important version, description and dependency information. The LuaRock 
server directory also contains a [LuaRock server 
manifest](http://luarocks.org/en/Manifest_file_format) file as a Lua 
executable (configuration file). The manifest contains both 
version/revision and dependency tables. Each LuaRock is a zip file 
containing both another copy of that LuaRock's rockspec as well as a 
Tar GZip file of all of the artifacts in the LuaRock.

The Java Ivy server relies on a more complex (sub)directory structure 
(which must be index-able). Each package directory contains a number of 
jar files containing the actual package artifacts (with a typical 
internal manifest file), as well as a sha1 digest sum of that 
particular package artifact. Each package also has a package manifest 
file in XML format which contains version, description and dependency 
information for each artifact in the overall package.

At least initially, it is highly likely that each mathematician will 
host their own diSimplex artifact server.  This means any browsing 
system will need to also be able to "walk" a peer-to-peer system of 
loosely linked repositories across the greater web.

At some point one or more repsoitories of "blessed" diSimplex proofs 
might appear. At this time existing diSimplex artifacts might migrate 
to these blessed repositories and their old locations may disappear.

## Goals

Provide a peer-to-peer distribution system over which individual 
researcher's diSimplex artifact browsers can walk displaying effective 
summary information about some overall collection of "known" diSimplex 
proofs.

## Requirements

> A repository MUST provide version, description and dependency 
> information about each diSimplex artifact and any included diSimplex 
> proof objects.

> A repository MAY provide links to other peer repositories that it 
> might know about.  (These links may be very circular).

> A repository MUST have a globally unique identifier.

> A repository MAY provide the unique identifier of one or more 
> repositories to which its diSimplex artifacts have been moved to.

> A diSimplex artifact/package MUST provide version, description and 
> dependency information about the diSimplex proof objects which it 
> contains.

> The repository version, description and dependency information for 
> each of its collected diSimplex artifacts, SHOULD be extracted 
> directly from the (La)TeX file(s) which define the diSimplex proof 
> objects.
