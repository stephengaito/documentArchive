# Search

## Problem

The user wants to be able to search the growing FandianPF system for 
specific items of interest.

We need to be able to search using both a fairly simple browser URL 
syntax as well as a more complex field driven syntax (when the need 
arrises).

## Requirements

> It should be simple to do simple searches.

> It should be possible to do more complex searches.

> It should be possible for automated processes to perform the same 
> searches (on behalf of a user) as a user can with a browser.

> All searches using URLs MUST be Google/SEO friendly.

> Searches must be do able using IDN characters.

## Background

It is important to review [Google's URL 
suggestions](https://support.google.com/webmasters/answer/76329?hl=en).

Here are a number of useful discussion about what characters can be 
used in a URL from around the web:

* [(Please) Stop Using Unsafe Characters in 
URLs](http://perishablepress.com/stop-using-unsafe-characters-in-urls/),

* [safe characters for 
URLs](http://stackoverflow.com/questions/695438/safe-characters-for-friendly-url),

* [UTF-8 characters in 
URLs](http://stackoverflow.com/questions/6625035/utf-8-characters-in-urls),

* [Internationalized domain name 
(IDN)](http://en.wikipedia.org/wiki/Internationalized_domain_name),

* [IDN in Google 
Chrome](http://www.chromium.org/developers/design-documents/idn-in-google-chrome),

## Solution

### Implicit JSON key search

(Implicit key) search will be indistinguishable from normal urls. If a URL 
is incomplete, then the server should just return a list of the 
matching JSON keys.

### Simple searches

Simple single/multiple keyword searches on whole text can be done using:

> /search/<<keyword1>>+<<keyword2>>/<<keyword3>>

More refined searches on a specific content type can be done using:

> /search/author/<<keyword1>>/<<keyword2>>

or

> /search/<<fieldName>>/<<keyword1>>/<<keyword2>>

or

> /search/<<fieldName>>!<<keyword1>>

In all cases multiple <<keywords>> separated by a '+' are anded.

Multiple groups of anded keywords separated by a '/' are ored.

### Advanced (complex) searches

We implement advanced search using rules similar to simple searches but 
instead we allow collections of different fields to be ANDed or ORed 
together using a simple JSON structure of nested arrays.  Each array 
starts with either 'and' or 'or' to denote how to combine the rest of 
the array.  Arrays which do not start with either 'and' or 'or' will be 
ORed. Each keyword can be prefixed by a fieldName separated from the 
keyword by a '!'. A fieldName followed only by a '!' will set the 
default fieldName for the rest of that array.

> ['or', ['and', ['or', ['or', 'fieldName!keyword', 'keyword']]]]


