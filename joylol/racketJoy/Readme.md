# Analysis of the Joy programming language 

This analysis contains a collection of mathematical papers exploring the 
formal structure of the Joy programming language as well as a minimal 
implemenation in Racket.

* A (partial) implementation of [Manfred von Thun's Joy programming 
language](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language) 
in [Racket](https://racket-lang.org/) can be found in the [racket 
directory](racket).

* A proof that a (super-set) of Joy is fully abstract can be found in 
the [fullyAbstractJoy directory](tex/fullyAbstractJoy).

## Rational

My primary aim is to gain a deeper understanding of a simple example of 
a [Concatenative programming 
language](https://en.wikipedia.org/wiki/Concatenative_programming_language), 
with a view to evolving it into a foundation for Mathematics (called 
diSimp).

As such I have no interest in implementing all of Joy's "atomic 
programs", only the smallest subset which makes Joy an extensible Turing 
complete langauge.

## The Joy programming language

The [Joy programming 
language](http://en.wikipedia.org/wiki/Joy_(programming_language)) was a 
[project](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language) 
of [Manfred von 
Thun](https://concatenative.org/wiki/view/Manfred%20von%20Thun) at [La 
Trobe University in 
Australia](http://www.latrobe.edu.au/politics-and-philosophy).

["A conversation with Manfred von 
Thun"](http://www.nsl.com/papers/interview.htm) provides an excellent 
brief history of the ideas behind the creation of Joy.

Mirrors of Manfred von Thun's papers outlining Joy can be found at:

* [La 
Trobe](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language)

* [Kevin 
Albrecht](http://www.kevinalbrecht.com/code/joy-mirror/joy.html)

* [XIE YuHeng](https://github.com/xieyuheng/joy)

Joy is a [concatenative programming 
language](https://en.wikipedia.org/wiki/Concatenative_programming_language). 

More information on concatenative programming languages can be found on 
the [concatenative.org website](http://www.concatenative.org).

## Formal theory of Programming Languages

Durring the end of the 1950's through the early 1980's there was a great 
deal of work attempting to provide a formal mathematical theory of the 
semantics of programming langauages.

We revist this theory and (minimally) extend it with an aim to provide a 
fully formal computational foundation for Mathematics.

## Licenses

The mathematical papers, contained in the [tex](tex) directory, are all 
Copyright PerceptiSys Ltd (Stephen Gaito) and released under a [Creative 
Commons Attribution-ShareAlike 4.0 International 
License](http://creativecommons.org/licenses/by-sa/4.0/). See the 
frontMatter.tex file of each paper.

The implementation of Joy, contained in the 
[racketJoy](racket/racketJoy) directory, is Copyright PerceptiSys Ltd 
(Stephen Gaito) and released under an [MIT 
License](racket/racketJoy/LICENSE.txt). See the associated LICENSE.txt 
file.
