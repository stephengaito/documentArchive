#lang racket

(provide (all-defined-out))

(displayln "Loaded basicJoy")

(define (newStack aStack) '() )

(define (sum aStack)
  (displayln "sum-implementation-")
  (displayln aStack)
  (displayln "sum-implementation=")
  (let ([ top0 (car aStack)  ]
        [ top1 (cadr aStack) ]
        [ rest (cddr aStack) ] )
    (cons (+ top0 top1) rest)
  )
)
