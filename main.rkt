#lang racket

(provide 
  (rename-out [ racket-joy-module-begin    #%module-begin    ])
  (rename-out [ racket-joy-top-interaction #%top-interaction ])
  (except-out (all-from-out racket) #%module-begin #%top-interaction)
)

(define-syntax-rule (racket-joy-module-begin aForm ...)
  (#%module-begin (racket-joy-eval 'aForm ) ...)
)

(define-syntax-rule (racket-joy-top-interaction . aForm)
  (racket-joy-eval 'aForm )
)

(define joyStack '())    ;; an empty immutable list/stack
(define joyTable (hash)) ;; an empty immutable hash table

(define (pushCommandListOnStack commandList aStack)
  (if (null? commandList)
    aStack
    (pushCommandListOnStack 
      (cdr commandList) (cons (car commandList) aStack))
  )
) 

(define (evalSymbol command aStack)
  (let ([ cmdImpl (hash-ref joyTable command 'unknown) ])
    (cond
      [ (procedure? cmdImpl) (apply cmdImpl aStack)
      ] [ (list? cmdImpl)    (cons cmdImpl aStack)
      ] [ else 
        (begin
          (displayln 
            (string-append "undefined command [" (~a command) "]"))
          (cons command aStack)
        )
      ]
    )
  )
)

(define (evalStack aStack) 
  (let ( [ command (car aStack) ]
         [ rest    (cdr aStack) ] )
    (cond
      [ (list? command)
        (evalStack (pushCommandListOnStack command rest) ) 
      ] [ (number? command) aStack
      ] [ (string? command) aStack
      ] [ (symbol? command) (evalSymbol command rest)
      ] [ else 
        (begin
          (displayln 
            (string-append 
              "unknown command [" (~a command) "] ignored"
            )
          )
          (evalStack rest)
        )
      ]
    )
  )
)

(define (racket-joy-eval someArgs)
  (set! joyStack 
    (if (eq? someArgs 'eval)
      (evalStack joyStack)
      (cons someArgs joyStack)
    )
  )
  (displayln joyStack)
)

(displayln "Hello from RacketJoy!")
(displayln joyStack)
