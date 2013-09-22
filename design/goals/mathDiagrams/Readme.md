**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Making mathematical and diagrammatic writing easy](#making-mathematical-and-diagrammatic-writing-easy)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)
	- [Solution](#solution)

# Making mathematical and diagrammatic writing easy

## Problem

Of necessity, technical discussions often make use of mathematical
arguments, equations and symbols. While there are a few exceptional
tools, it is still, in June 2013, very difficult to write short "bits"
of mathematical content on or for the "Web".

Most current tools for putting mathematical symbols on the web, so
seriously interrupt the flow of thought to the point that it is, by and
large, "not worth bothering" writing mathematics on the web.

This lack of good mathematical content on the web seriously inhibits
the understanding of the general public about mathematics and its
associated subjects.

Similarly, diagrams are often beneficial in providing a visual tool to
help orient a technical discussion.  Again it is critically important
that creating these diagrams, should not interrupt the flow of thought
in writing about the technical subject.

The use of an "external" diagramming tool for "simple" diagrams, both
interrupts the flow of thought *and* (potentially) creates a very
disjointed collection of artefacts.  Ideally "simple" diagrams should
be "drawn" using "textual" instructions which can be directly embedded
in a given "note".

## Goals

Writing new (mathematical) content in FandianPF should be as easy as
using LaTeX.

## Requirements

> The FandianPF system MUST provide a TeX/LaTeX filter to transcribe
> (simple) TeX/LaTeX macros into MathJAX or MathML content.

> The FandianPF system MUST provide a set of simple textural macros
> which can expand into SVG content.

> It should be possible to reuse "diagrams" in multiple "notes" if
> desired.

> The FandianPF system MUST provide a simple textural "markup" system
> (such as Markdown or Creole).

> The FandianPF system MIGHT provide a WYSIWYG editor.

> Any such WYSIWYG editor MUST not interfere with the use of textural
> macros or other markup.

## Solution
