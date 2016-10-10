#lang racket

(require racket/rerequire)
(require racket/enter)

(module undefinedSymbols racket
  (require racket)
  (provide (rename-out [ racket-joy-top #%top ] ) )

  ;; inspired by: http://stackoverflow.com/a/20087085
  (define-syntax-rule (racket-joy-top . anId)
    (racket-joy-push-unknown-id 'anId)
  )

  (define (racket-joy-push-unknown-id anId)
    (lambda (aStack)
      (begin
        (cons anId aStack)
      )
    )
  )
)

(require 'undefinedSymbols)

(define-namespace-anchor racketJoy-namespace-anchor)
(define racketJoy-namespace 
  (namespace-anchor->namespace racketJoy-namespace-anchor)
)

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

(define joyStack '())

(define (extendJoy aStack)
  (let ( [ moduleName (car aStack) ] )
    (eval `( require ,moduleName ) racketJoy-namespace)
  )
  (cdr aStack)
)

(require "basicJoy.rkt")

(define (pushCommandListOnStack commandList aStack)
  (displayln commandList)
  (displayln aStack)
  (if (null? commandList)
    aStack
    (pushCommandListOnStack (cdr commandList) (cons (car commandList) aStack))
  )
) 

(define (i aStack) 
  (let ( [ command (car aStack) ]
         [ rest    (cdr aStack) ] )
    (if (list? command)
      (i (pushCommandListOnStack command rest))
      (begin
        (displayln "i-implementation-")
        (displayln command)
        (displayln rest)
        (displayln "i-implementation=")
        (eval `( ,command (quote ,rest) ) racketJoy-namespace)
      )
    )
  )
)

(define (racket-joy-eval someArgs)
  (if (symbol? someArgs)
    (set! joyStack (eval `( ,someArgs joyStack) racketJoy-namespace) )
    (set! joyStack (cons someArgs joyStack))
  )
  (displayln joyStack)
)

(displayln "Hello from RacketJoy!")
(displayln joyStack)
