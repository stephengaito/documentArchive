#lang racket/base

;; This is the main entry point for the racketLayer language.
;;

;; It is used to control which aspects of the underlying Racket 
;; language/engine are allowed to be used in the overlying 
;; STLCAlg/STLCCoAlg/DTLCAlg/DTLCCoAlg languages/engines.

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
  require provide rename-out all-from-out
  define lambda
  list list* list? list-tail length
  cons car cdr cadr cddr caddr cadddr
  quote
  if case else
  equal? eqv? eq?
  and not
  null
  + -
  displayln
)

