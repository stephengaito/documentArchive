#lang racket

(require racket/promise)
(require net/url-string)
(require
  xml
  xml/path
)
(require
  web-server/http/request-structs
  web-server/http/response-structs
)

(provide
  url->string
  request-uri
  request-method
  build-request
  response-body
  response-code
  begin-equal?
  select
)

(define (build-request method uri)
  (request
    method
    (string->url uri)
    (list (header #"Accept-Charset" #"utf-8"))
    (delay (lambda () (binding #"unknownId")))
    #f
    "127.0.0.1"
    8080
    "127.0.0.1"
  )
)

(define (response-body aResponse)
  (define aBodyPort (open-output-string))
  ((response-output aResponse) aBodyPort)
  (string->xexpr (get-output-string aBodyPort))
)

(define (begin-equal? pattern anXexpr)
  ;;(displayln (list "equal-pattern" pattern (symbol? pattern) (string? pattern) (bytes? pattern)))
  ;;(displayln (list "equal-anXexpr" anXexpr (symbol? anXexpr) (string? anXexpr) (bytes? anXexpr)))
  (if (equal? pattern anXexpr)
    ;;(begin (displayln "SUCCESS pattern == anXexpr") #t)
    #t
    (if (empty? pattern)
      ;;(begin (displayln "SUCCESS pattern empty") #t)
      #t
      (if (and (list? pattern) (list? anXexpr))
        (if (< (length anXexpr) (length pattern))
          ;;(begin (displayln "FAILED anXexpr too short") #f)
          #f
          (if (begin-equal? (car pattern) (car anXexpr))
            (begin-equal? (cdr pattern) (cdr anXexpr))
            ;;(begin (displayln (list "FAILED cars not equal" (car pattern) (car anXexpr))) #f)
            #f
          )
        )
        ;;(begin (displayln "FAILED not both lists") #f)
        #f
      )
    )
  )
)

(define (select pattern anXexpr)
  ;;(displayln (list 'SELECT-pattern pattern))
  ;;(displayln (list 'SELECT-anXexpr anXexpr))
  (let 
    ( [ init
      (if (begin-equal? pattern anXexpr)
        (list (list anXexpr))
        '()
      )
    ] )
    (foldl
      (lambda (subXexpr init)
        (if (list? subXexpr)
          ;;(begin
            ;;(displayln (list 'subXexpr subXexpr))
            (append* init (select pattern subXexpr))
          ;;)
          init
        )
      )
      init
      anXexpr
    )
  )
)

