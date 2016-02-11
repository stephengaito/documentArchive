#lang scribble/manual
@require[@for-label[diSimp]]
@require[scribble/bnf]

@title{diSimp}
@author{Stephen Gaito}

@defmodule[diSimp]

Package Description Here

@section{Syntax}

We begin by providing the syntax of our diSimplex proof language 
following the standard set by 
@hyperlink["http://www.eopl3.com/"]{Essentials of Programming Languages}.

@BNF[(list @nonterm{Program} @nonterm{Expression})]

@codeblock[#:indent 15]{(program (exp1))}

@BNF[(list @nonterm{Expression} @nonterm{List})]

@codeblock[#:indent 15]{(list (list1))}

@BNF[(list @nonterm{Expression} 
           @BNF-seq[@litchar{cons} @nonterm{List} @nonterm{List}])]

@codeblock[#:indent 15]{(cons list1 list2)}

@BNF[(list @nonterm{Expression} @BNF-seq[@litchar{car} @nonterm{List}])]

@codeblock[#:indent 15]{(car list1)}

@BNF[(list @nonterm{Expression} @BNF-seq[@litchar{cdr} @nonterm{List}])]

@codeblock[#:indent 15]{(cdr list1)}

@BNF[(list @nonterm{Expression} @BNF-seq[@litchar{null?} @nonterm{List}])]

@codeblock[#:indent 15]{(null? list1)}

@BNF[(list @nonterm{Expression} 
           @BNF-seq[@litchar{if} @nonterm{Expression} 
                    @litchar{then} @nonterm{Expression}
                    @litchar{else} @nonterm{Expression}])]

@codeblock[#:indent 15]{(if exp1 exp2 exp3)}

@BNF[(list @nonterm{Expression} @nonterm{Identifier})]

@codeblock[#:indent 15]{(var var1)}

@BNF[(list @nonterm{Expression} 
           @BNF-seq[@litchar{let} @nonterm{Identifier} 
                    @litchar{=} @nonterm{Expression}])]

@codeblock[#:indent 15]{(let var exp1)}

@BNF[(list @nonterm{List} @BNF-seq[@litchar{(} @litchar{)}])]

@codeblock[#:indent 15]{(null-list)}
