#lang lp4RacketLayer

(provide
  kind?
  kind
  type?
  tfree-type?
  tfree-type
  tfree-type-name
  func-type?
  func-type
  func-type-domain
  func-type-range
)

(define (kind? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Star)
  )
)

(define (kind)
  (list 'Star)
)

(define (type? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ (TFree Func) #t ]
      [ else #f ]
    )
  )
)

(define (tfree-type? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'TFree)
  )
)

(define (tfree-type aTypeName)
  (list 'TFree aTypeName)
)

(define (tfree-type-name aTFreeType)
  (cadr aTFreeType)
)

(define (func-type? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Func)
  )
)

(define (func-type domainType rangeType)
  (list 'Func domainType rangeType)
)

(define (func-type-domain aFuncType)
  (cadr aFuncType)
)

(define (func-type-range aFuncType)
  (caddr aFuncType)
)
