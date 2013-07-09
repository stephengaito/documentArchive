**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Sprint 002 Configuration and Simple Datastore](#sprint-002-configuration-and-simple-datastore)
	- [Tasks](#tasks)
	- [Cucumber features](#cucumber-features)
	- [RSpec specifications](#rspec-specifications)
	- [Questions and Risks](#questions-and-risks)
		- [User input sanitisation](#user-input-sanitisation)
		- [Authentication options](#authentication-options)
			- [OpenID](#openid)
			- [OAuth](#oauth)
			- [HTTPSC (two way HTTPS)](#httpsc-two-way-https)
			- [VPN](#vpn)
		- [Deployment options](#deployment-options)
			- [Tablet](#tablet)
			- [Standard desktop, Amazon, or VPS instances](#standard-desktop-amazon-or-vps-instances)
			- [Heroku](#heroku)
			- [Google Apps](#google-apps)

# Sprint 002 Configuration and Simple Datastore

 * Started: 2013/06/28 Friday
 * Paused: 2013/07/01 Monday (to review VPS providers)
 * Re-started: 2013/0709 Tuesday
 * Ends: 2013/07/012 Friday

## Tasks

 1. adjust configuration/authentication/deployment requirements
 1. investigate user input sanitization
 1. investigate authentication options
 1. investigate deployment options
 1. investigate configuration options
 1. attempt to create Padrino sample_blog application with OpenID and 
OAuth authentication.
 1. run cucumber/RSpec loop...

## Cucumber features

 1. none at the moment...

## RSpec specifications

 1. none at the moment...

## Questions and Risks

### User input sanitisation

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

### Authentication options

#### OpenID

**Background** can be found on 
[Wikipedia](http://en.wikipedia.org/wiki/OpenID) and 
[OpenID](http://openid.net/).

**Suggested OpenID suppliers** [MyOpenID](https://www.myopenid.com/), 
Facebook, Google, Yahoo, Twitter, Orange, Flickr, Blooger, Wordpress, 
AOL, VeriSign, claimID, PayPal, ...

**Ruby** 

 * [openid/ruby-openid](https://github.com/openid/ruby-openid) seems to 
be the standard

 * [nov/openid_connect](https://github.com/nov/openid_connect) more 
recently created and worked upon but has fewer forks. See both 
[nov/openid_connect_sample](https://github.com/nov/openid_connect_sample) 
and 
[nov/openid_connect_sample_rp](https://github.com/nov/openid_connect_sample_rp) 
for examples of how to use this library. nov also has an OAuth library.

 * [josh/rack-openid](https://github.com/josh/rack-openid) is Rack 
middleware which automates the request for openid credentials.

It looks like both ruby-openid and openid-connect should work with jRuby.

**Does Padrino's authentication framework inter-operate with opneID?**

#### OAuth

**Background** can be found at 
[Wikipedia](http://en.wikipedia.org/wiki/OAuth) and 
[OAuth](http://oauth.net/).

**Note that Wikipedia's article suggests that there are serious 
problems with OAuth v2.0**

**Can we use OAuth v1.0a or should we consider a different protocol?**

**Does Padrino's authentication framework inter-operate with OAuth?**

Could we use [Tav's OAuth 
v3.0](http://tav.espians.com/oauth-3.0-the-sane-and-simple-way-to-do-it.html)?

**Is simple HTTPSC sufficient?**

**Discussion on OAuth alternatives** 

 * [Alternatives to 
OAuth?](http://programmers.stackexchange.com/questions/86115/alternatives-to-oauth) 
which contains a number of links to the security discussion.

 * [Weakness in oAuth 2.0 - what are the 
alternatives?](http://stackoverflow.com/questions/10947586/weakness-in-oauth-2-0-what-are-the-alternatives).

> **It is safe to use OAuth2 if you are not using SSL?** No. Right now 
> bearer tokens are the only mature standards out there for access 
> tokens and they must be secured using SSL on every API call. 
> Furthermore (and more importantly) even if you end up using another 
> type of token, all the authorisation flows to actually get the token 
> have to be encrypted as well. 

The is from [OAuth 2.0: Don’t Throw the Baby Out with the Bathwater 
(Webcast 
Q&A)](https://blog.apigee.com/detail/oauth_20_don_t_throw_the_baby_out_with_the_bathwater_webcast_qa), 
which is very important to read.

I guess the best alternative is to very very carefully cherry pick the 
parts of the specification that we need and keep it very very simple.

Have a look at 

 * [OAuth 2 
Simplified](http://aaronparecki.com/articles/2012/07/29/1/oauth2-simplified)

 * [Google Accounts Authentication and Authorization: Choosing an Auth Mechanism](https://developers.google.com/accounts/docs/GettingStarted)

 * [OAuth - A great way to cripple your API 
](http://insanecoding.blogspot.co.uk/2013/03/oauth-great-way-to-cripple-your-api.html) 
is a **VERY** **GOOD** summary of the problems with current OAuth.

 * [More API Security Choices - OAuth, SSL, SAML, and rolling your 
own](https://blog.apigee.com/detail/more_api_security_choices_oauth_ssl_saml_and_rolling_your_own).

**Ruby**

 * [oauth-xx/oauth-ruby](https://github.com/oauth-xx/oauth-ruby) seems 
to be the standard OAuth library for Ruby. It seems to use OAuth v1.0 
(does it have the fix for OAuth v1.0a?). Is this the rubyGems oauth? It 
seems to be from the list of developers. Check the version numbers.


#### HTTPSC (two way HTTPS)

From a quick review of the [Puma](http://puma.io/) code, it looks like 
it does not currently support the use of client SSL certificates ([Two 
way](http://en.wikipedia.org/wiki/Mutual_authentication) see also 
[Transport Layer 
Security](http://en.wikipedia.org/wiki/Secure_Sockets_Layer) ). It 
looks like it would be possible to add this function and then 
contribute the fix back to the main development at some future time.

From an equally quick look at the Ruby HTTP code, it looks like people 
say one can establish client connections to HTTPS servers which use two 
way authentication... but I can not really see where in the code this 
happens.

See: 

 * [How to validate SSL certificate chain in ruby with net/http](http://stackoverflow.com/questions/2507902/how-to-validate-ssl-certificate-chain-in-ruby-with-net-http)

 * [Ruby 1.8.7 and Net::HTTP: Making an SSL GET request with client cert?](http://stackoverflow.com/questions/8991036/ruby-1-8-7-and-nethttp-making-an-ssl-get-request-with-client-cert)

 * in the http.rb code, there is a discussion about the cert and 
cert_store options in the documentation above the HTTP.start function 
definition.

#### VPN

 * [OpenVPN](http://openvpn.net/) is the lightest weight VPN, all other 
POSIX/Linux based VPNs require access to the kernel to make 
modifications.

 * OpenVPN has servers on all POSIX/Linux as well as windows computers.

 * OpenVPN has clients on all POSIX/Linux as well as windows computers.

 * OpenVPN can NOT be used with either Heroku or Google Apps, since the 
clients require access to the TUN Ethernet interface.

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
processe](https://devcenter.heroku.com/articles/run-non-web-java-processes-on-heroku) 
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
