**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Administrative interfaces.](#administrative-interfaces)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Administrative interfaces.

## Problem

Balancing the twin goals of making administration of a FandianPF
instance both easy and secure will be an interesting challenge.

Web-interfaces will probably be the most natural admin interface for
private FandianPF instances used by either a single researcher or a
small team on a secure VPN.

Configuration files or command line interfaces would probably be the
most secure way to administer a highly public FandianPF interface.

## Goals

Provide a set of flexible *and* secure administrative interfaces.

## Requirements

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


