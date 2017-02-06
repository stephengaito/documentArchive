# ToDo

Things to do:

## Text wrap for TeX paragraphs

* use http://lua-users.org/wiki/SplitJoin on the text obtained from 
textadept.editing.select_paragraph()

* add '%' to modules/textadept/editing.lua M.comment_string['context'] 
='%'

* prepend lines whose paragraphs begin with %xxx with %nnn

## Add LaTeX->ConTeXt transformation tool

## Make ctags support conditional on having Textredux module installed

## Add support (ctags/build) for projects with multiple files

* should use io.get_project_root(dirName)
* see <textAdept>/modules/ansi_c/init.lua : tags_files
* see <textAdept>/modules/textadept/find.lua
* see <textAdept>/modules/textadept/run.lua
