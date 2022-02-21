#lang lp4RacketLayer

;; This is the main entry point for the STLCAlg module/language

(require 
  "namesData.rkt"
  "typesData.rkt"
  "typesCtxData.rkt"
  "typesProc.rkt"
  "termsData.rkt"
  "termsProc.rkt"
  "valuesData.rkt"
  "valuesProc.rkt"
)

(provide 
  (all-from-out
    "namesData.rkt"
    "typesData.rkt"
    "typesCtxData.rkt"
    "typesProc.rkt"
    "termsData.rkt"
    "termsProc.rkt"
    "valuesData.rkt"
    "valuesProc.rkt"
  )
)
