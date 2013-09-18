**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [ToDo list](#todo-list)
	- [Potential Solutions](#potential-solutions)
		- [Secure access](#secure-access)
			- [Question](#question)
	- [List of previously researched links](#list-of-previously-researched-links)
		- [Spam comments](#spam-comments)
		- [BDD](#bdd)
		- [Writing dual C/C++ and Java gems](#writing-dual-cc++-and-java-gems)
		- [LaTeX and BibTex](#latex-and-bibtex)
		- [OpenID](#openid)
		- [OAuth](#oauth)
		- [Web hacking (know your "enemy")](#web-hacking-know-your-enemy)

# ToDo list

## Potential Solutions

### Secure access

The discussion surrounding OAuth suggests that it is too complex and, in 
particular, inappropriate for unattended secure access.

All secure access solutions depend upon shared secrets of one form or 
another.  ALL secure communication essentially depends upon SSL/TLS or 
SSH in one form or another.  In our web based systems, this really 
means SSL/TLS.

**Communication which is NOT over HTTPSC, is fundamentally insecure.**

However the administrator of any particular FandianPF instance may, for 
reasons of ease of use and expediency, choose to use "lower levels of 
security".  

So we need to enable the use of HTTPSC but not require it.

Our preferred webserver, Puma, is both light weight (small amount of 
code), and able to be used as is with both MRI and jRuby 
implementations.  (If Puma proves impossible to "fix" then we might 
consider either [Mizuno](https://github.com/matadon/mizuno) or 
[Kirk](https://github.com/strobecorp/kirk) both of which are tied to 
Jetty and Java; see: [C Extension 
Alternatives](https://github.com/jruby/jruby/wiki/C-Extension-Alternatives) 
).

However, Puma is not, at the moment, able to use client SSL 
certificates. It *looks* like it should be easy to add the required 
additional code to Puma at some future date and contribute it back to 
the main distribution with a GitHub pull request.

Equally problematic is the fact that while most desktop browsers allow 
the use of client SSL certificates, the two Android browsers, Chrome 
and FireFox, do not.  At some point in the future we should consider 
adding the required Chrome or FireFox code which would enable the use 
of client SSL certificates.

Our current preferred solution for secure access is to use HTTPS for 
initial development, and at some time in the medium term, add the code, 
to Puma, which is required to make use of client SSL certificates.

Tablet users using a desktop or VPS based based FandianPF instances in 
the medium term could use a VPN based setup (which *is* essentially 
HTTPSC by a very different route). (Note that this will *not* work for 
Heroku or Google App based instances).

#### Question

**Can ruby's HTTP clients library use client certificates?**

## List of previously researched links

### Spam comments

* http://searchanddresscue.com/2011/03/how-to-deal-with-splogs-content-theft/
* http://searchanddresscue.com/2011/04/how-to-deal-with-spam/

### BDD

* http://software-as-a-craft.blogspot.co.uk/2011/01/relishing-in-perfection-doing-bdd-right.html
* http://software-as-a-craft.blogspot.co.uk/2011/01/relishing-in-perfection-ii-chef-in.html
* http://software-as-a-craft.blogspot.co.uk/2011/01/relishing-in-perfection-iii-writing.html
* http://dannorth.net/whats-in-a-story/
* http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/

### Writing dual C/C++ and Java gems

* http://ola-bini.blogspot.co.uk/2006/10/jruby-tutorial-4-writing-java.html

### LaTeX and BibTex

* http://inukshuk.github.io/bibtex-ruby/

### OpenID

* https://www.ruby-toolbox.com/search?utf8=%E2%9C%93&q=openid+server
* https://github.com/nov/openid_connect/tree/master/lib
* http://bogomips.org/local-openid/

### OAuth

### Web hacking (know your "enemy")

* http://coding.smashingmagazine.com/2011/01/11/keeping-web-users-safe-by-sanitizing-input-data/
* https://www.ruby-toolbox.com/search?utf8=%E2%9C%93&q=HTML+filter
* http://rubyworks.github.io/htmlfilter/
* https://github.com/3aHyga/hscrubber

* http://www.webhackingexposed.com/tools.html
* http://www.manvswebapp.com/web-hacking-survival-kit/tools
* http://www.hackersonlineclub.com/hacking-tools
* http://www.hackersonlineclub.com/website-hacking
* http://www.hackersonlineclub.com/website-security
* http://www.hackersonlineclub.com/website-security-tools
* http://www.computerhackingtools.com/how-to-become-a-hacker/


