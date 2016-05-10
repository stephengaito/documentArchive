**Table of Contents**

  - [Language artefacts](#language-artefacts)
    - [Problem](#problem)
      - [Syntax](#syntax)
      - [Axioms](#axioms)
    - [Goals](#goals)
    - [Requirements](#requirements)
      - [Backus-Naur Form for language artefact](#backus-naur-form-for-language-artefact)
    - [Solution](#solution)
    - [Questions and Risks](#questions-and-risks)
      - [Syntax](#syntax)
      - [Axioms](#axioms)
    - [Resources](#resources)

<!--- END TOC -->

# Language artefacts

## Problem

Any given language has two parts, the syntax and its base collection of 
axioms.

### Syntax

At the moment we will only worry about the [Abstract 
Syntax](https://en.wikipedia.org/wiki/Abstract_syntax) as represented by 
its associated [Abstract Syntax Tree 
(AST)](https://en.wikipedia.org/wiki/Abstract_syntax_tree).

Could consider [ragg](http://www.hashcollision.org/ragg/) 
[example](http://stackoverflow.com/a/12358029) and [Lexical analysis in 
Racket](http://matt.might.net/articles/lexers-in-racket/) and the example 
[Parsing BibTeX](http://matt.might.net/articles/parsing-bibtex/). See 
also [HashCollision's projects](http://www.hashcollision.org/). See also 
[Racket 
Parsers](http://www.markcarter.me.uk/programming/racket/parsers.htm).

### Axioms

Any language will have a small collection of axioms.

Each axiom, as any other theorem/lemma, will consist of a pre-condition, 
a proof sequence, and a post-condition. For an axiom the proof sequence 
will simply to be "name" of the axiom.

## Goals

## Requirements

> A language's syntax WILL be specified as the collection of additional 
> keywords and their arities.

> A language's axioms WILL be a list of axioms.

> Each axiom WILL consist of an axiom-name, a list of pre-conditions, a 
> null body, and a list of post-conditions.

### Backus-Naur Form for language artefact

| Language element    | Symbol or Racket list structure |
| ---------------     | ------------------------------- |
| < language >        | 'language' < name > < syntaxDecl > < axioms > |
| < name >            | [a-zA-Z0-9-_]+ |
| < syntaxDecl >      | 'syntax' < keywordPairs >+ |
| < keywordPairs >    | < name > < arity > |
| < arity >           | [0-9]+ |
| < axioms >          | 'axioms' < axiom >+ |
| < axiom >           | 'axiom' < name > < pre-conditions > < body > < post-conditions > |
| < pre-conditions >  | < pre-condition>+ |
| < pre-condition >   | 'pre-condition' ?? |
| < body >            | 'body' |
| < post-conditions > | < post-condition >+ |
| < post-condition >  | 'post-condition' ?? |

Where in addition, each language element is expressed as a Racket list.

## Solution

## Questions and Risks

* how will we navigate to complete collection of languages?
* how will we ensure language "namespaces" do not conflict?

### Syntax

* Should we use simple [Backus-Naur 
Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form)?

* Alternatively, should we simply use a simple array/list of the additional 
keywords and their arity, which are used over and above the Racket list 
structure?

* Certainly we should limit the syntax to a [context-free 
language](https://en.wikipedia.org/wiki/Context-free_language)

* ( strictly speaking we do not *yet* know that a number is... so what is 
an arity? Or for that matter, what is a character? ;-) )

### Axioms

* What *is* a pre-condition? What *is* a post-condition?

## Resources

We are basing our axioms on a form of the [Floyd-Hoare 
"logic"](https://en.wikipedia.org/wiki/Hoare_logic). A particularly 
important summary of these ideas can be found in Gries [The Science of 
Programming](http://link.springer.com/book/10.1007%2F978-1-4612-5983-1).
