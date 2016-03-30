#lang racket/base

;; This is the main entry point for the lp4RacketLayer language.
;;

;; It is used to control which aspects of the underlying Racket 
;; language/engine are allowed to be used in the overlying 
;; STLCAlg/STLCCoAlg/DTLCAlg/DTLCCoAlg languages/engines.

;; We carefully restrict the symbols/methods to ensure a "simple" 
;; underlying system.
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
  let begin
  if case else
  equal? eqv? eq?
  and not
  null
  + - <
)

