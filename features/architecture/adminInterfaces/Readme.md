**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Administrative interfaces.](#administrative-interfaces)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)
	- [Solution](#solution)

# Administrative interfaces.

## Problem

Balancing the twin goals of making administration of a FandianPF
instance both easy and secure will be an interesting challenge.

Web-interfaces will probably be the most natural admin interface for
private FandianPF instances used by either a single researcher or a
small team on a secure VPN.

Configuration files or command line interfaces would probably be the
most secure way to administer a highly public FandianPF interface.

The Padrino "way" is to do configuration via Ruby in the three 
config/apps.rb, config/boot.rb and config/databases.rb files.  Since 
one of the typical deployments will be via a Gem install, these three 
files will not usually be editable, so we will need to allow most 
configuration parameters to be specified by non-rubists via a simpler 
YAML settings file which could potentially be located anywhere in the 
file system.

## Goals

Provide a set of flexible *and* secure administrative interfaces.

Provide a simple collection of textural settings which will cover most 
of the required administration.

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

> The administrator MUST be able to make most configurational settings 
> via a YAML settings file.

## Solution

We use the [Sinatra configuration 
settings](http://www.sinatrarb.com/configuration.html) to set 
application wide options. This [system is used by 
Pardino](http://www.padrinorb.com/blog/padrino-0-9-27-project-settings-routing-compatibility-and-bug-fixes) 
to set both application specific and application global settings.

We load the config/settings.yml file via the config/boot.rb file so 
that the settings are loaded before all other Padrino setup.

The :server, :host, :port, :daemonize, :pid and :debug settings are 
extracted from the config/settings.yml file and merged with the 
fandianpf command line options to be passed Padrino.run! command.
