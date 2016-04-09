#lang racket/base

;; This is the main entry point for the diSimpRacketLayer language.
;;

;; It is used to control which aspects of the underlying Racket
;; language/engine are allowed to be used in the overlying diSimp
;; language/engine.

;; This form is very restrictive
;;
(provide
  define-syntax-rule ; private/misc required for #%module-begin and #%top-interaction
  #%plain-module-begin
  (rename-out [#%plain-module-begin #%module-begin])
  #%app #%datum #%top
  #%require #%provide
  require provide rename-out
;  define
;  list list? 
;  car cdr cadr caddr cadddr
;  quote
;  if case else
;  equal? eqv? eq?
;  and
;  null
  displayln
)

