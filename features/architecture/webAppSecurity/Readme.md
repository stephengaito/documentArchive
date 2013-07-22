**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [WebApp security and User input sanitisation](#webapp-security-and-user-input-sanitisation)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Research](#research)
	- [Requirements](#requirements)

# WebApp security and User input sanitisation

## Problem

Like it or not, there are people out there who will try to break any 
security systems we might put in place to control access to a FandianPF 
instance. This will be a significant problem for any highly public web 
application.

While we do not want to become so paranoid that the application becomes 
impossible for normal use, we *do* want to ensure all of the obvious 
vulnerabilities are protected against.

## Goals

Ensure any FandianPF instance is as difficult to hack as feasibly 
possible.

## Research

There is a distinction between sanitisation and validation. Validation 
is inherently more detailed and probably should be done by the domain 
model. Sanitisation should be done by the rack middleware while the 
data is still a collection of strings.

Consider:

 * [Sanitize and Validate Data with PHP 
Filters](http://net.tutsplus.com/tutorials/php/sanitize-and-validate-data-with-php-filters/)

 * [How do I build a Rack middleware as form 
validator](http://stackoverflow.com/questions/14491306/how-do-i-build-a-rack-middleware-as-form-validator) 
[FormValidator](https://github.com/thefonso/form_challenge/blob/master/app/middleware/form_validator.rb)

 * [Rack Content-Type Validator 
middleware](https://github.com/abril/rack-content_type_validator)

 * [chrisdurtschi/rack-sanitize](https://github.com/chrisdurtschi/rack-sanitize/blob/master/lib/rack/sanitize.rb)

 * [Sanitize](https://github.com/rgrove/sanitize/)

   > Sanitize is a whitelist-based HTML sanitizer. Given a list of 
   > acceptable elements and attributes, Sanitize will remove all 
   > unacceptable HTML from a string.

   > Using a simple configuration syntax, you can tell Sanitize to 
   > allow certain elements, certain attributes within those elements, 
   > and even certain URL protocols within attributes that contain 
   > URLs. Any HTML elements or attributes that you don’t explicitly 
   > allow will be removed.

   > Because it’s based on Nokogiri, a full-fledged HTML parser, rather 
   > than a bunch of fragile regular expressions, Sanitize has no 
   > trouble dealing with malformed or maliciously-formed HTML, and 
   > will always output valid HTML or XHTML.

 * 
[Rack::UTF8Sanitizer](https://github.com/whitequark/rack-utf8_sanitizer#usage)

   > Rack::UTF8Sanitizer is a Rack middleware which cleans up invalid 
   > UTF8 characters in request URI and headers.

Note that we must also sanitise URI parameters as well as HTTP headers. 
See the summaries in "Hacking Web Applications Exposed" chapters 5 
through 10.

## Requirements

> ALL user input MUST be scanned for malicious intent.

> Consider using Rack middleware to scan all inbound requests for 
> security violations.

