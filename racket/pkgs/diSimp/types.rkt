#lang racketLayer

(provide
  name?
  global-name?
  global-name
  global-name-str
  local-name?
  local-name
  local-name-index
  quote-name?
  quote-name
  quote-name-index
  type?
  tfree-type?
  tfree-type
  tfree-type-name
  func-type?
  func-type
  func-type-domain
  func-type-range
)

(define (name? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ (Global Local Quote) #t ]
      [ else #f ]
    )
  )
)

(define (global-name? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'Global)
  )
)

(define (global-name aString)
  (list 'Global aString)
)

(define (global-name-str aGlobalName)
  (cadr aGlobalName)
)

(define (local-name? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'Local)
  )
)

(define (local-name aNumber)
  (list 'Local aNumber)
)

(define (local-name-index aLocalName)
  (cadr aLocalName)
)

(define (quote-name? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'Quote)
  )
)

(define (quote-name aNumber)
  (list 'Quote aNumber)
)

(define (quote-name-index aQuoteName)
  (cadr aQuoteName)
)

(define (type? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ (TFree Func) #t ]
      [ else #f ]
    )
  )
)

(define (tfree-type? someThing)
  (and (list? someThing)
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
