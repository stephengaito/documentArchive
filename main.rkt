#lang racket

(require racketJoy/internals)
(require racketJoy/coreJoy)

(provide 
  (rename-out [ racket-joy-module-begin    #%module-begin    ])
  (rename-out [ racket-joy-top-interaction #%top-interaction ])
  (except-out (all-from-out racket) #%module-begin #%top-interaction)
)

(define-syntax-rule (racket-joy-module-begin aForm ...)
  (#%module-begin (addArgsToJoyStack 'aForm ) ...)
)

(define-syntax-rule (racket-joy-top-interaction . aForm)
  (addArgsToJoyStack 'aForm )
)

(displayln "Hello from RacketJoy!")
