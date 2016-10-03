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

(define (diSimp aStructure)
  (let ( [ prog   (car  aStructure) ]
         [ pTree (cadr aStructure) ]
         [ fTree (cddr aStructure) ] )
    (cond
      [ (equal? diSimp::popTag prog)
        (append noopList (popOp pTree fTree)) ]
      [ (equal? diSimp::consTag prog)
        (append noopList (consOp pTree fTree)) ]
      [ (equal? diSimp::treeTag prog)
        (append noopList (treeOp pTree fTree)) ]
      [ (equal? diSimp::unTreeTag prog)
        (append noopList (unTreeOp pTree fTree)) ]
      [ (equal? diSimp::newTreeTag prog)
        (append noopList (newTreeOp pTree fTree)) ]
      [ else aStructure ]
    )
  )
)
