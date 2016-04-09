#lang diSimpRacketLayer

;; This is the main entry point for the diSimp module/language

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
  (rename-out [#%plain-module-begin #%module-begin])
  #%app #%datum #%top
  #%require #%provide
  displayln
)

