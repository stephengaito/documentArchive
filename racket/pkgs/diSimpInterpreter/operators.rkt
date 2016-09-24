#lang diSimpRacketLayer

(provide 
  noop
  noopList
  noopOp
  pop
  popList
  popOp
)

(define noop '() )
(define noopList '(()) )
(define (noopOp aStack) aStack)

(define pop  '(()) )
(define popList '((())) )
(define (popOp aStack) (cdr aStack) )
