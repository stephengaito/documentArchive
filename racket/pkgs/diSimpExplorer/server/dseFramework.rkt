#lang racket

(provide zepto-js )

(define zepto-js
  (list
    "zepto/zepto.min.js"
  )
)

(require racket/runtime-path)
(define-runtime-path zepto-java-script "../browser/vendor/zepto")
(define-runtime-path work-space-dir
  (if (directory-exists? "languages")
    (current-directory)
    "../specs/workspace"
  )
)

(define (dir->divString aDir)
  (list
    "  <div class=\"language\">"
    (path->string aDir)
    "</div>\n"
  )
)

(require "./restfulServlets.rkt")
;;(get "/languages"
(get "/"
  (lambda ()
    (string-append*
      (flatten
        (list 
          "<div class=\"languages\">"
          (map dir->divString 
            (directory-list (build-path work-space-dir "languages"))
          )
          "</div>"
        )
      )
    )
  )
)

(require "./binaryServlets.rkt")
(get-file "/zepto" zepto-java-script 3600 )
