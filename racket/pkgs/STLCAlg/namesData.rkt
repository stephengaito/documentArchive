#lang lp4RacketLayer

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
)

(define (name? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ (Global Local Quote) #t ]
      [ else #f ]
    )
  )
)

(define (global-name? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
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
    (< 0 (length someThing))
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
    (< 0 (length someThing))
    (eq? (car someThing) 'Quote)
  )
)

(define (quote-name aNumber)
  (list 'Quote aNumber)
)

(define (quote-name-index aQuoteName)
  (cadr aQuoteName)
)


