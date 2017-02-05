-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

-- Initialization for the ConTeXt module

-- remove the default mapping from *.tex to pdflatex
textadept.run.compile_commands.tex = nil

-- add the mapping from the context lexer to context
textadept.run.compile_commands['context'] = 'context %f'

return M
