-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

-- Initialization for the LaTeX module

-- remove the default mapping from *.tex to pdflatex
textadept.run.compile_commands.tex = nil

-- add the mapping from the latex lexer to pdflatex
textadept.run.compile_commands['latex'] = 'pdflatex %f'

return M
