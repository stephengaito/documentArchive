#lang racket

(require "utils.rkt")

(addSpec "ShowStackOn"
  'showStackOn
  (list "()" "")
)

(addSpec "A comment: add comment to stack"
  "This is a comment"
  (list "(This is a comment)" "")
)

(addSpec "A comment: pop comment off stack"
  'comment
  (list "()" "")
)

(addSpec "Another comment: add comment to stack"
  "This is another comment"
  (list "(This is another comment)" "")
)

(addSpec "Another comment: pop comment off stack"
  '--
  (list "()" "")
)

(addSpec "Simple stack"
  '(+ 1 1)
  (list "((+ 1 1))" "")
)

(addSpec "deeper stack"
  '(+ 2 2 )
  (list "((+ 2 2) (+ 1 1))" "")
)

(runSpecsOn "rJoy")
