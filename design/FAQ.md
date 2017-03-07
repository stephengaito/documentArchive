# FAQ

A good introduction to specific features of ConTeXt can be found in the most 
recent version (that you can find) of the 'ConTeXt Mark IV: an excursion' 
document. On disk this PDF might be called ma-cb-en.pdf. 

You can obtain a version with working PDF bookmarks by: 

> cp -R <contextInstallation>/tex/texmf-context/doc/context/sources/general/manuals/start .

placing:

> \setupinteraction
>  [state=start,
>   color=green,
>   style=bold]
> % make chapter, section bookmarks visible when opening document
> \placebookmarks[chapter,section,subsection][chapter,section]
> \setupinteractionscreen[option=bookmark]

just **after** the line:

> \unprotect

in the file: ma-cb-style.tex, cd'ing into the **en** directory and then 
typing: 

> context ma-cb-en

**[Project structure](http://wiki.contextgarden.net/Project_structure)** To 
create a document for a particular **product** cd into the directory in which 
that particular project's *.tex file is stored and then type:

> context <productName>.tex

The *project file* defines all of the related styles which are common across 
all of the products, while it is the individual *product files* which get 
typeset by ConTeXt. 

[Command summary on ConTeXt 
Garden](http://wiki.contextgarden.net/Category:Commands) 

[Modes](http://wiki.contextgarden.net/Modes)

[How to add PDF 
bookmarks/contents](http://wiki.contextgarden.net/PDF_Bookmarks_and_Headers) 

[Aditya's TugBoat articles](http://tex.stackexchange.com/a/2938) [on 
GitHub](http://github.com/adityam/context-articles) 

