#lang racketLayer

;; This is the main entry point for the STLCAlg module/language

(require 
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
    "typesData.rkt"
    "typesCtxData.rkt"
    "typesProc.rkt"
    "termsData.rkt"
    "termsProc.rkt"
    "valuesData.rkt"
    "valuesProc.rkt"
  )
)
