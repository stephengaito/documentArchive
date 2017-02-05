-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

function initLaTeX(lexerName)
  if lexerName == 'context' then
    -- Initialization for the ConTeXt module

    -- remove the default mapping from *.tex to pdflatex
    textadept.run.compile_commands.tex = nil

    -- add the mapping from the context lexer to context
    textadept.run.compile_commands['context'] = 'context %f'

    -- add some latex snippets
    snippets['context'] = snippets['context'] or {}
    snippets['context']['start'] = 'start%1\n%0\n\\stop%1'
  end
end

events.connect(events.LEXER_LOADED, initLaTeX)

return {}
