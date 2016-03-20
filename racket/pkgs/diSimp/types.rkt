#lang racketLayer

(provide
  type?
  tfree-type
  func-type
)

(define (type? aType) #t)

(define (tfree-type aTypeName)
  (list 'TFree aTypeName)
)

(define (func-type domainType rangeType)
  (list 'Func domainType rangeType)
)
