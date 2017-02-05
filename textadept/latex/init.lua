-- Copyright 2017 Stephen Gaito. See License.md

function initLaTeX(lexerName)
  if lexerName == 'latex' then
    -- Initialization for the LaTeX module

    -- remove the default mapping from *.tex to pdflatex
    textadept.run.compile_commands.tex = nil

    -- add the mapping from the latex lexer to pdflatex
    textadept.run.compile_commands['latex'] = 'pdflatex %f'

    -- add some latex snippets
    snippets['latex'] = snippets['latex'] or {}
    snippets['latex']['begin'] = 'begin{%1}\n%0\n\\end{%1}'
  end
end

events.connect(events.LEXER_LOADED, initLaTeX)

return {}
