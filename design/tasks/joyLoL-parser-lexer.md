# JoyLoL parser/lexer 

## Goal

Write a Lua LPeg based Parser/Lexer module for JoyLoL.

## Tasks ![notStarted](/design/images/notStarted.png)

### Write an LPeg parser for lists of lists ![notStarted](/design/images/notStarted.png)

Write a simple LPeg parser to read lists of lists:

> (() () ((())))

### Write JoyLoL parser ![notStarted](/design/images/notStarted.png)

A JoyLoL parser will be used by the joyLoL interpreter to parse joyLoL 
code into an interpretable list of lists (an abstract syntax tree). 

### Write Textadept lexer ![notStarted](/design/images/notStarted.png)

A Textadept lexer is used by textadept to recognize and color joyLoL code 
in the editor. 

## Questions 

### How do we make an extensible parser? 

A future user needs to be able to add a Parser/Lexer for a currently 
unknown CoAlgebra. How do we do this? 

