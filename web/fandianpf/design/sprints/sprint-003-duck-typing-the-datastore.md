**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Sprint 003 Semi-structured JSON content and duck-typing the Datastore](#sprint-003-semi-structured-json-content-and-duck-typing-the-datastore)
	- [Tasks](#tasks)
	- [Cucumber features](#cucumber-features)
	- [RSpec specifications](#rspec-specifications)
	- [Questions and Risks](#questions-and-risks)
		- [Duck-typing vs Rigid-typing](#duck-typing-vs-rigid-typing)
		- [Search](#search)
		- [Base hierarchy](#base-hierarchy)
		- [Ajax](#ajax)
		- [SEO URLs](#seo-urls)
	- [Wrap-up](#wrap-up)

# Sprint 003 Semi-structured JSON content and duck-typing the Datastore

 * Started: 2013/07/30 Tuesday
 * Paused while holding Papa's hand, and celebrating his life.
 * Paused while packing/unpacking and travelling back home.
 * Ends: 2013/09/27 Friday

## Tasks

 1. Understand how to manage overlapping hierarchical classifications 
of "duck-typed" content.
 1. Understand SEO best practices for URLs to content.

## Cucumber features

None at the moment.

## RSpec specifications

None at the moment.

## Questions and Risks

### Duck-typing vs Rigid-typing

**Problem:** We explicitly want to work with semi-structured (JSON 
based) content. Inevitably such semi-structured content will not lie in 
nicely distinct hierarchical classes.

In particular, different users will inevitably want to see the same 
item of content in differing ways, as different "duck-types".

On the other hand we as humans have a strong need for hierarchical 
classifications, so that we can manage the cognitive overload of 
simple heaps of things.

How do we manage this overlapping hierarchical structure?

We could have a database table which is indexed by any json key in any 
json object, whose value is an array of any registered json structures 
(e.g. "bibtex book") known to contain that key.

We could then return a page with tabs for all registered json 
structures whose default selected tab is most common registered json 
structure for that collection of keys.

At some point in the future we could use Bayesian keyword analysis (see 
spam tools) to learn what individual and or the "default" user prefers 
to see the given collection of keys as.

For each registered json structure we could/should have a call back 
which provides any required JavaScript/CSS.

### Search

Search will be indistinguishable from normal urls. If a URL is 
incomplete, then the server should just return a list of the matching 
entities.

### Base hierarchy

basic search areas?

 * title/%title%
 * date/%yyyy%/%mm%/%dd%/%title%
 * author/%name%
 * reference/%refID%
 * reference/%yyyy%/%refID%
 * reference/%authors%/%yyyy%/%refTag%
 * reference/%type%/%yyyy%/%refID%
 * reference/%type%/%authors%/%yyyy%/%refTag%
 * review/????
 * blog/????
 * glossary/%tag%
 * tag/%tag%
 * keyword/%tag%
 * paper/%authors%/%yyyy%/%mm%/%title%
 * wiki/????
 * version/????
 * task/????
 * issue/????

other areas?

 * admin/????
 * user/????
 * Zotero/?????

life cycle areas?

 * show/%title%
 * edit/%title%
 * save/%title%

if we http-get on a node that does not exist, we return edit on the 
same node with the given default title.

if we http-post on a node that does not exist, we do a save on that 
node.

if we http-get on edit a node and we request (x)HTML then we return a 
form with the existing contents of this node.  The corresponding form 
with http-post to save on the same node.

if we http-get a node and we request json then we simply return json.

if we http-post a node and we request json then we simple save that json.

if we http-delete a node then we delete the corresponding json object 
(or create an empty version).

### Ajax

 1. [Padrino-pjax example](https://github.com/nesquena/padrino-pjax) 

### SEO URLs

What is SEO best practice for URLs to the content?

 1. [Google's 
PDF](http://www.google.co.uk/webmasters/docs/search-engine-optimization-starter-guide.pdf)

 1. [SMX 
suggestions](http://www.smartinsights.com/search-engine-optimisation-seo/seo-strategy/seo-best-practices-2013-london/)

 1. 
[Hongkiat](http://www.hongkiat.com/blog/beginners-guide-to-seo-best-practices-part-23/)

 1. [Specifying Canonical 
URLs](http://googlewebmastercentral.blogspot.com/2009/02/specify-your-canonical.html)

 1. [Use Schemas to provide semantic categorization](http://schema.org/)

 1. [Use Google+ to identify 
authority](http://www.quicksprout.com/2012/09/17/author-rank-a-step-by-step-guide-to-dominating-search-with-content-marketing/)

 1. [Moz SEO guide](http://moz.com/beginners-guide-to-seo)

 1. [SEO checklist](http://www.orbitmedia.com/blog/seo-best-practices)

### Bibliographic references

See [bibJSON](http://www.bibjson.org/), 
[CSL](http://citationstyles.org/) and the datamodel to CSL's 
[citeproc-js](https://bitbucket.org/fbennett/citeproc-js/wiki/Home).  
See also [citeproc-ruby](https://github.com/inukshuk/citeproc-ruby).

HOWEVER, as an internal model we will use the BibLaTeX model (as loaded 
by [bibtex-ruby](https://github.com/inukshuk/bibtex-ruby)) and possibly 
in a JSON variant for storage in the database.  See: [BibLaTeX 
manual](http://mirrors.ctan.org/macros/latex/contrib/biblatex/doc/biblatex.pdf) 
[blx-dm.def -- basic field 
definitions](http://mirrors.ctan.org/macros/latex/contrib/biblatex/latex/blx-dm.def), 
[does bibtex-ruby provide biblatex 
support?](https://github.com/inukshuk/bibtex-ruby/issues/44)

[Here is a brief justification of why BibLaTeX is better then 
CSL](http://tex.stackexchange.com/questions/69267/citation-style-language-csl/69284#69284)

### Interworking with Zotero and Docear

Zotero will be use primarily as a referenc *capture* tool for getting, 
reading and annotating (using Okular) PDF files as references.

I *might* keep a fair number of references in Zotero, however Zotero's 
CSL internal model is (reputedly) not up BibLaTeX's internal reference 
model. AND I like to keep notes about authors, institutions, and more 
extensive blog entries... all of which suggests that my prefered 
reference tool will be FandianPF.

I think I might use Docear to mind map and explore literature for 
specifice projects. At the moment I do not see it as capable of keeping 
my nearly 3000 references in any comprehensive way (the "database" is a 
simple flat biblatex file ;-(

SO, at this point, FandianPF will be my main reference "database".  
Zotero will be used to crop references from the web (and may end up 
storing most of these). Docear will be used to explore a specific 
topic/paper.  Zotero will inter-communicate with FandianPF using 
biblatex (needs a pluging to be developed) and webdav. Docear will 
inter-communicate with FandianPF using biblatex (via exports to the 
file system) and webdav (to download specific documents).

Implications for FandianPF.

1. We need to provide and configure a WebDav based "file system" for 
(local) document storage.

1. We need to provide get and put of biblatex formated content, of 
either single entries or bulk collections.

1. We need to provide get and put of extended biblatex to allow notes 
associated to an individual paper.

1. We need to provide get and put of extended biblatex to allow for 
authors and institutions to have "paper" like entries.

1. We need to cross link entries using textual (as opposed to 
traditional foriegn key) associations.

1. We should provide Zotero friendly RDF on all appropriate FandianPF 
pages.

1. We might consider a Zotero plugin to allow author and insitution 
enties in the internal model.


## Wrap-up

Nothing at the moment.
