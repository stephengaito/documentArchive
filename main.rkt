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

(define joyStack '())
(define (clearStack) (set! joyStack '()) )
(define (showStack)  (displayln joyStack) )

(define (racket-joy-eval someArgs)
  (let ( [ command (car someArgs) ] )
    (set! joyStack (cons someArgs joyStack))
    (displayln joyStack)
  )
)

(displayln "Hello from RacketJoy!")
(clearStack)
(showStack)
