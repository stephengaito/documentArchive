#lang racket/base

;; This is the main entry point for the racketLayer language.
;;

;; It is used to control which aspects of the underlying Racket
;; language/engine are allowed to be used in the overlying diSimp
;; language/engine.

#|
;; This form opens everything out and is TOO permissive
;;
(provide (except-out (all-from-out racket/base) #%module-begin)
         (rename-out [#%plain-module-begin #%module-begin])
)
|#


;; This form, if it works, is very restrictive
;;
(provide
  #%plain-module-begin
  (rename-out [#%plain-module-begin #%module-begin])
  #%app #%datum #%top
  #%require #%provide
  require provide rename-out
  define
  list list? 
  car cdr cadr caddr
  quote
  case else
  eq?
  and
  displayln
)

