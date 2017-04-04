# Objectives

## Goal 

We build a suite of tools which collectively implement an 
interpreter-verifier (of the JoyLoL language). Before being interpreted, 
any code text will be deductively verified for correct adherence to a 
given specification. A full verification report should provide details of 
any dependence upon code which is only inductively (that is, 
non-deductively) verified. 

The interpreter-verifier must be extensible.

The interpreter-verifier should be easily targeted by a range of cross 
compilers. 

The interpreter-verifier must itself be both deductively verified and its 
underlying composite implementation model must be inductively verified as 
comprehensively as possible. Together, the deductive/inductive 
verification provides a formal semantic definition of the JoyLoL language. 

### Interpreter

The interpreter provides a user, such as a mathematician, scientist or 
engineer, a tool with which to explore the use of various possible code 
implementations for fitness of purpose as well as verifiability. 

### Deductive Verifier

The *deductive* verifier provides a user a tool with which to deductively 
prove that a given code text implements a given specification.

**Note** that deductive verification depends upon two assumptions:

1. That the interpreter-verifier is itself *deductively* correct. 

2. That the interpreter-verifier's underlying composite implementation 
model is *inductively* correct. 

### Inductive Verifier

The *iductive* verifier provides a user a tool with which to provide, as 
comprehensively as possible, a collection of tests that a given code text, 
which can't otherwise be deductively verified, conforms to a given 
specification. 

**Note** that unlike deductive verification, inductive verification can never 
be 100% certain. Inductive verification can only ever *test* a given code 
text conforms to a given specification "well enough" for a given amount of 
effort. This corresponds to the fact that *scientific* models of reality 
can never be proven "true" but can only ever be tested (i.e. not yet 
refuted). 

## Problems

### "Bootstrapping"

Given that the interpreter-verifier must *itself* be both deductively and 
inductively verified, we have a problem: *what verifies the primordal 
instance?* 

Essentially this is the same problem as, for example, the first Unix C 
compiler had. We follow a similar solution: we hand code a reasonably 
reliable initial interpreter-verifier, and then begin to 'write' 
subsequent versions using previous interpreter-verifiers. Each subsequent 
interpreter-verifier should provide increasingly comprehensive levels of 
verification. 

## Solution 

We will use a hybrid of JoyLoL, Lua, C, String-templates as the initial 
underlying implementation languages. We will use C to code any 
computationally highly varying component. We will use Lua for any 
computationally slowly varying component. 

Any command-line tools will be Bash scripts which load an initial Lua 
instance together with any appropriate JoyLoL/Lua/C/String-template 
libraries. 

Each component part is likely to be one or more 
JoyLoL/Lua/C/String-template libraries. 

The JoyLoL/Lua/C/Sting-template libraries will interface with each other 
over Lua->C, C->C, C->Lua and Lua->Lua interfaces. (What about 
{JoyLoL, String-template}<->XXX interfaces?) 

We produce the following collection of extensions: 

1. **Language parser(s)**: We simply parse JoyLoL to an 'Abstract Parse 
Tree'. However, since JoyLoL is explicitly its own formal semantics, the 
abstract parse tree of JoyLoL is essentially an internal representation of 
the JoyLoL language itself as Lists of Lists. 

2. **Lists of Lists**: Maintains internal representations of JoyLoL Lists 
of Lists as well as tools to 'collect garbage' (i.e. collect lists of 
lists which are no longer reachable from the 'base' collection of lists). 

3. **Strings**: String of characters.

4. **Symbols**: Symbols are strings which are placed in a global dictionary.

5. **Numbers**: Integers

6. **Computational contexts**: Maintains a collection of pairs of Lists of 
Lists (the data and process stacks). 

7. **Lists of Lists interpreter**: This is essentially a JoyLoL extension 
which manipulates computational contexts. It must maintain the currently 
known collection of extensions, as well as a namespace based dictionary of 
defined 'symbols'. 

8. **Lists of Lists deductive verifier**: 

9. **Lists of Lists inductive verifier**: (is this *just* a Lua/C unit 
tester of the composite Lua/C implementation model?) 

10. **Lists of Lists cross compiler (to Lua and C)**: Is a JoyLoL 
meta-program which cross compiles a Lists of Lists into a JoyLoL 
extension. 

11. **Language unparser(s)**: A template engine which can be used, by for 
example the cross compiler, to generate complex structured strings. 

### Extensions 

An extension is a collection of JoyLoL/Lua/C/String-template code which 
together provide various interfaces conforming to specificed 
specifications. 

An extension must be able to register itself with the JoyLoL 'shell' 
(itself an extension) and ultimately with the Lua interpreter. 

An extension must declare any external JoyLoL objects/methods required by 
the extension. 

An extension must be able to maintain a registry of its component 
computational artefacts. 

Any *significant* component method must provide:

1. **A human language description** of the method as well as descriptions 
of the stack elements assumed and the structure of the stack returned. 

3. **A pre/post specification** which provides a rigorous deductive 
description of the method. 

4. A collection of **inductive tests** which provide sufficient coverage 
of the implementation code. 

1. **A Lua callable interface**. Since JoyLoL is stack based, there is 
essentially only *one* type of Lua interface. 

2. **A C callable interface**. Since JoyLoL is stack based, there is 
essentially only *one* type of C interface. 

5. A JoyLoL or String-template description of the method sufficient for a 
cross-compiler to rebuild the extension component. 

An extension description is a specially structured [ConTeXt]() document 
which uses the JoyLoL ConTeXt module. It is written in a mixture of 
JoyLoL, as well as Lua and C via JoyLoLTemplates. 

# Ideas

See [Compilation of Stack-Based 
Languages](http://www.complang.tuwien.ac.at/projects/rafts.html) 

[Writing an LLVM Backend](http://llvm.org/docs/WritingAnLLVMBackend.html) 

[StringTemplates](http://www.stringtemplate.org/) 

[Enforcing Strict Model-View Separation in Template 
Engines](http://www.cs.usfca.edu/~parrt/papers/mvc.templates.pdf) 

[Using Lua as a Templating 
Engine](https://john.nachtimwald.com/2014/08/06/using-lua-as-a-templating-engine/) 

[labels as values in 
clang](http://stackoverflow.com/questions/36983970/labels-as-values-in-clang) 

