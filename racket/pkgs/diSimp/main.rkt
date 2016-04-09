#lang diSimpRacketLayer

;; This is the main entry point for the diSimp module/language


;; The following (taken from collects/racket/load) represents the 
;; minimal code required to allow diSimp to be used as a REPL language 
;; without exporting ALL of racket

(define-syntax-rule (module-begin form ...)
  (#%plain-module-begin (top-interaction . (#%top-interaction . form)) ...))

(define-syntax-rule (top-interaction . form) form)

;; This form, if it works, is very restrictive
;;
(provide 
  (rename-out [module-begin #%module-begin]
              [top-interaction #%top-interaction])
  #%app #%datum #%top
  #%require #%provide
  displayln
)

