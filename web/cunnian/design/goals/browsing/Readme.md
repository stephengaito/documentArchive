**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Browsing peer-to-peer repositories of diSimplex proofs](#browsing-peer-to-peer-repositories-of-disimplex-proofs)
	- [Problem](#problem)
	- [Goals](#goals)
	- [Requirements](#requirements)

# Browsing peer-to-peer repositories of diSimplex proofs

## Problem

Researchers will vary in the maturity of their ability to form 
diSimplex proof objects. While all proof objects will be checked for 
validity and hence will be "Valid", proof objects will still vary in 
their generality and hence usefulness for a particular problem. This 
suggests one particularly important aspect of any diSimplex artifact 
will be its authour.

As time goes by, the mathematical community steadily improves its 
understanding of the correct way to state and use a mathematical proof.  
This suggests that the date that a given diSimplex artifact was 
"completed" (checked and uploaded) will be important to individual 
researchers browsing a repository.

Individuals and groups of researchers in a given field may provide 
"libraries" of significant "standard" diSimplex proofs in a given area.  
As time goes by they will probably want to make small changes to their 
collection of standard proofs. This suggests that diSimplex artifacts 
should have version/revision information in the form of version numbers 
and summaries of changes made.

As libraries of "standard" diSimplex proof objects get versioned and 
revised, previous versions may be deemed to be depreciated or 
superseded by newer versions.

As the number of diSimplex artifacts grows a researcher's ability to 
find a particular "useful" artifact will get progressively harder.  
There should be some simple mechanisms for narrowing this search.

## Goals

Provide a efficient interface to locate a given diSimplex artifact 
and/or proof object.

## Requirements

> diSimplex artifacts SHOULD be browsable by their authour.

> diSimplex artifacts MUST be browsable by the date they were 
> registered.

> diSimplex artifacts MUST be browsable by version identifier.

> diSimplex artifacts MUST be browsable by the "depends upon" 
> dependency relations.

> diSimplex artifacts MAY be browsable by the "depended on" dependency 
> relation (in so far as it is locally known or cached).

> diSimplex artifacts MUST be browsable by any superseded 
> relationships.

> diSimplex artifact MAY provide conflicts with relationships.

> A particular version of a diSimplex artifacts SHOULD provide 
> release/change information in a form a repository browser can show to 
> a (human) user.

> diSimplex artifacts SHOULD have summary descriptive information for 
> itself and all of its versions/revisions.

> diSimplex artifacts SHOULD provide a list of search-able keywords 
> which collectively describe the artifact enabling efficient browsing 
> by keyword.

> diSimplex artifacts SHOULD provide a list of collectively agreed 
> classification codes which collectively categorize a given artifact, 
> enabling efficient browsing by classification code.

> A diSimplex repository browser SHOULD be able to search locally known 
> or cached information about all artifacts a given browser knows 
> about.

> A diSimplex repository browser MIGHT be able to ask peer repositories 
> to seach their known or cached information about all artifact they 
> know about.

