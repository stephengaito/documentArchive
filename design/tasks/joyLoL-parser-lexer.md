# JoyLoL parser/lexer 

## Goal

Sketch the infrastructure to provide multiple languages for JoyLoL. Each 
langauge should be provided by a distinct JoyLoL Language module.

To begin we write a two distinct languages with diametrically opposite 
syntactical styles, JoyLoL (proper) and WhileRecLoL. We provide an initial 
Lua LPeg based Parser/Lexer module for both. 

## Tasks ![notStarted](/design/images/notStarted.png)

### Write an LPeg parser for lists of lists ![notStarted](/design/images/notStarted.png)

Write a simple LPeg parser to read lists of lists:

> (() () ((())))

### Write JoyLoL parser ![notStarted](/design/images/notStarted.png)

A JoyLoL parser will be used by the joyLoL interpreter to parse joyLoL 
code into an interpretable list of lists (an abstract syntax tree). 

In this case the formal semantics is JoyLoL itself.

### Write a Textadept lexer for JoyLoL ![notStarted](/design/images/notStarted.png)

Provide a Textadept lexer as used by textadept to recognize and color 
joyLoL code in the editor. 

### Write an LPeg parser for WhileRecLoL ![notStarted](/design/images/notStarted.png)

A WhileRecLoL parser will parse to an abstract syntax tree which can be 
further transformed to a LoL structure which can be interpreted by the 
JoyLoL interpreter. 

In this case the ultimate formal semantics for WhileRecLoL is JoyLoL. 

### Write a Textadept lexer for WhileRecLoL ![notStarted](/design/images/notStarted.png)

Provide a Textadept lexer as used by textadept to recognize and color 
whileRecLoL code in the editor. 

## Questions 

### How do we make an extensible parser? 

A future user needs to be able to add a Parser/Lexer for a currently 
unknown CoAlgebra. How do we do this? 

