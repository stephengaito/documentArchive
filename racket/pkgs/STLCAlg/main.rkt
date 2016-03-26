#lang racketLayer

;; This is the main entry point for the STLCAlg module/language

(require 
  "typesData.rkt"
  "valuesData.rkt"
  "termsData.rkt"
  "contextsData.rkt"
  "valuesProc.rkt"
)

(provide 
  (all-from-out
    "typesData.rkt"
    "valuesData.rkt"
    "termsData.rkt"
    "contextsData.rkt"
    "valuesProc.rkt"
  )
)
