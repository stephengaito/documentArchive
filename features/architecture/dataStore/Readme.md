**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Problem: Semi-structured datastore](#problem-semi-structured-datastore)
	- [Goals](#goals)
		- [Requirements](#requirements)

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


