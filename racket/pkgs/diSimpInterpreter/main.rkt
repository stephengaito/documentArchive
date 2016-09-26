#lang diSimpRacketLayer

;; This is the main entry point for the diSimpInterpreter module/language


;; The following (taken from collects/racket/load) represents the 
;; minimal code required to allow diSimpInterpreter to be used as a REPL 
;; language without exporting ALL of racket

(define-syntax-rule (module-begin form ...)
  (#%plain-module-begin (top-interaction . (#%top-interaction . form)) ...))

(define-syntax-rule (top-interaction . form) form)

(require (prefix-in diSimp:: diSimpInterpreter/operators))
(require (submod diSimpInterpreter/operators privateAPI))

;; This form, if it works, is very restrictive
;;
(provide 
  (all-from-out diSimpInterpreter/operators)
  (rename-out [module-begin #%module-begin]
              [top-interaction #%top-interaction])
  #%app #%datum #%top
  #%require #%provide
  define
  list list?
  car cdr cadr caddr cadddr
  quote
  if case else
  equal? eqv? eq?
  and
  null
  displayln
  diSimp
  ;; we want to provide all of constants.rkt with a prefix-in 
  ;; of 'diSimp::'
)

(define (diSimp aList)
  (let ( [ prog  (car aList) ]
         [ stack (cdr aList) ] )
    (cond
      [ (equal? diSimp::pop prog)
        (append noopList (popOp stack)) ]
      [ (equal? diSimp::stack prog)
        (append noopList (stackOp stack)) ]
      [ (equal? diSimp::unStack prog)
        (append noopList (unStackOp stack)) ]
      [ (equal? diSimp::newStack prog)
        (append noopList (newStackOp stack)) ]
      [ else aList ]
    )
  )
)
