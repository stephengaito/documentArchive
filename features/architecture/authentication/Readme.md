**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [User authentication](#user-authentication)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Research](#research)
		- [OWASP](#owasp)
		- [Authentication options](#authentication-options)
			- [OpenID](#openid)
			- [OAuth](#oauth)
	- [Requirements](#requirements)

# User authentication

## Problem

In any long lived system which will accumulate a large amount of
valuable data, there is a need for various different users to maintain
different aspects of the system.

We need to ensure different users, with differing roles, have
appropriate levels of access to modify the system.

## Goals

Provide flexible user accounts based upon the OpenID standard.

## Research

In reality we have two very different authentications needs. Firstly we 
need to authenticate individual humans as they make active use of a 
FandianPF instance. Secondly we need to authenticate semi-autonomous 
remote processes as they interact with a given FandianPF instance.

It would make the code base considerably simpler if the authenticated 
access_tokens were the same.  That is, while the authentication flow 
might be different in the above two cases, the result of authentication 
in both cases is the same authentication access_token (with suitable 
identificaitons embedded in the token).

Review: [SO's Guide to website 
Authentication](http://stackoverflow.com/questions/549/the-definitive-guide-to-forms-based-website-authentication)

### OWASP

 * [OWASP](https://www.owasp.org/index.php/Main_Page) a good "Wikipedia 
of security".

 * [How To 
Guides](https://www.owasp.org/index.php/Category:How_To)

 * [Top Ten 
problems/solutions](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project)

 * [Authentication Cheat 
Sheet](https://www.owasp.org/index.php/Authentication_Cheat_Sheet)

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

 * [Google Accounts Authentication and Authorization: Choosing an Auth 
Mechanism](https://developers.google.com/accounts/docs/GettingStarted)

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

 * [intridea/oauth2](https://github.com/intridea/oauth2) is a more 
recent implementation of OAuth v2.0 along the lines of FaceBook's 
implementation.  Seems to implement ONLY Bearer access_tokens

 * [nov/rack-oauth2](http://github.com/nov/rack-oauth2) implements both 
Bearer and MAC access_tokens

## Requirements

> There SHOULD be different levels of "users" consisting (but not
> necessarily limited to): "Administrators", "Editors", "Authors",
> "Commenters", "Readers", "Spammers"(!?).

> These different "users" WILL have differing levels of access to
> access or alter content or otherwise control the contents of the
> system.

> Administrators, Editors, and Authors MUST be identified to the system
> with an "account".

> Commenters MIGHT be allowed to leave a comment by only using an (one
> off) OpenID to identify themselves.

> Commenters NEED NOT have an account on a given FandianPF instance.

> Readers MIGHT not need to identify themselves.

> There MIGHT be a list of blocked Spammers.

> It MUST be possible to link accounts between different instances of
> FandianPF.

> Local accounts MIGHT be "externalised" to other FandianPF instances
> by making FandianPF an OpenID provider.

> Users on one instance of FandianPF need not have the same privileges
> on a linked instance of FandianPF.

> The quality of an OpenID provider known to a FandianPF instance
> SHOULD be ranked.

> This OpenID provider ranking MIGHT be used in filtering spam.

> This OpenID provider ranking MIGHT be used in user authentication.


