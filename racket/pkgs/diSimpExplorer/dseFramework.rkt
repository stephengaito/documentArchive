#lang racket

(provide zepto-js )

(define zepto-js
  (list
  )
)

(require racket/runtime-path)
(define-runtime-path zepto-java-script "javascript")

(define (dir->scriptString aDir)
  (list
    "  <div class=\"language\">"
    aDir
    "</div>\n"
  )
)

(require "./restfulServlets.rkt")
(get "/languages"
  (lambda ()
    (string-append*
      (flatten
        (map dir->scriptString (directory-list "languages"))
      )
    )
  )
)

(require "./binaryServlets.rkt")
(get-file "/zepto" zepto-java-script 3600 )
