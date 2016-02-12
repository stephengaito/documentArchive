#lang racket/base

(provide
  null-list-exp?
)

#|
 
|#
(define (null-list-exp? listExp)
  (eq? (car listExp) 'null)
)
