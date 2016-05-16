#lang racket
(require web-server/servlet
         web-server/servlet-env)
 
(define (start req)
  (response/xexpr
    (list 'html 
      '(head (title "Hello world!"))
      (list 'body
        '(p "Hey out there!")
        (list 'pre (pretty-format (url-path (request-uri req))))
        (list 'pre (pretty-format (url-query (request-uri req))))
      )
    )
  )
)
 
(serve/servlet start
               #:servlet-path "/index.html"
               #:servlet-regexp #rx"^/silly"
               #:extra-files-paths
                 (list (build-path "angularFrontEnd"))
)
