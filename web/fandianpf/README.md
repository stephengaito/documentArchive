**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [FandianPF](#fandianpf)
	- [Usage](#usage)
	- [Development](#development)

# FandianPF

[FandianPF Scientific Publishing Framework](wiki/home), a 
[Padrino](http://www.padrinorb.com/) gem

## Usage

Add the following to your `Gemfile`:

```ruby
gem 'fandianpf'
```

and mount the app in your `apps.rb`:

```ruby
Padrino.mount("Fandianpf::App").to("/fandianpf")
```

## Development

For development, this gem can be run as a standalone Padrino application
as you would expect from a normal one:

```ruby
$ bundle exec padrino start
```

The Rakefile also works like the normal Padrino one and supports all standard
components.
