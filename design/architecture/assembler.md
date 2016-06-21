# diSimp assembler language

# Problem

Provide a programming language, compiler and interpreter which is 
rigorously correct, and more over type-checks all code.

# Goals

We **must**, at least initially, do this with a language simple enough to 
be understood by a human relatively easily, in order to convince the 
mathemtical community.

# Requirements

> MUST provide no extraneous features (that is for other more complex 
> languages).

> MUST be based upon car/cdr/cons/nil? of List of Lists (Lisp).

# Solution

Model the diSimp language on a functional typed concatenative programming 
language, such as either 
[cat](http://www.codeproject.com/Articles/16247/Cat-A-Statically-Typed-Programming-Language-Interp) 
(now defunct?) or [Kitten](http://kittenlang.org/).

We want functional conctentative since any concatenative language is 
essentially a category (topos) where the objects are the various "stack" 
instances (or "sets" of stack instances) (or other data models) and the 
morphisms are the concatenative language programs themselves.

We want *fully* statically type-checked language to provide the most 
succinct description of any algorithm / sub co-algebra. Also these 
type-checks are essentially nothing more (nor less) than the Axiomatic 
definition of the language.

We will implement this language in the LoL "assember" language:

* "car"/"cdr"/"cons"
* "nil?"

The conditions/assertions are the co-algebraic duals to the algebraic
manipulations. That is the universe, \universe{}, *is* the collection of
all mathematical objects which can be "observed" (i.e. "repsond" to the
"car"/"cdr"/"nil?" manipulations) as often as we like, yielding another
mathematical object. That is the universe is the collection of
mathematical objects which are "shapped" like LoL. They are essentially
LoL assembler processes.

The current first-order axiomatisations of Set Theory (for example ZFC),
*assume* a *collection* of things. Those "things" which satisfy the
axioms are *sets*.

One way to "understand" this is that the universe of ZFC sets is the
co-algebraic collection of mathematical processes which can always be
manipulated in the way the axioms of ZFC stipulate.

The standard "types" of the diSimp language will be finite structures 
which act as assertions on any underlying co-algebra, such as 
\universe{}.

# Questions and Risks

How do we type check a functional concatenative language?

* examples: [Kitten](http://kittenlang.org/) and 
[Cat](http://www.codeproject.com/Articles/16247/Cat-A-Statically-Typed-Programming-Language-Interp) 
are both statically type checking functional concatenative languages (and 
possibly the only ones).


# Resources

* Section 6.9 of [Introduction to Coalgebra. Towards Mathematics of
States and
Observations](http://www.cs.ru.nl/B.Jacobs/CLG/JacobsCoalgebraIntro.pdf)
defines sub-co-algebras, via rules and assertions.

* [Concatenative language wiki](http://concatenative.org)

* [The Joy of Concatenative 
Languages](http://www.codecommit.com/blog/category/cat)

  * [The Joy of Concatenative Languages Part 3: Kindly 
    Types](http://www.codecommit.com/blog/cat/the-joy-of-concatenative-languages-part-3)
