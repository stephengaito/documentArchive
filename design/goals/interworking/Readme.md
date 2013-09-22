**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Interworking with external tools and repositories](#interworking-with-external-tools-and-repositories)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)
	- [Solution](#solution)

# Interworking with external tools and repositories

## Problem

The FandianPF system will never "exist" on its own. There are numerous
research tools with which it would be useful for a given researcher's
FandianPF system to inter-operate.

For example many researchers collect references and papers using the
Zotero system.

Similarly many researchers use an external reference system such as
BibTeX files, or a structured reference management system such as
Docear.

Docear is built on the Freeplane mind mapping tool. The ability to
process a mind map into a collection of "notes" would be useful.

Many researchers will have existing external (time-series) data
collection, storage and analysis tools. However they might want to
store some or all of their data in FandianPF to facilitate collection
(while in the field) and/or discussion of the data.

## Goals

It is critical that it be easy to build interface tools for researchers
to access the content they have in the FandianPF system using "other"
tools.

## Requirements

> The FandianPF system MUST provide RESTful interfaces.

> Access to these RESTful interfaces MUST be via OAuth authentication.

> It SHOULD be possible to secure the transfer of content via any
> RESTful interface using SSL/TSL/SSH.

## Solution
