#lang racketLayer

(provide
  kind?
  kind
  info?
  kind-info?
  kind-info
  kind-info-kind
  type-info?
  type-info
  type-info-type
)

(define (kind? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'Star)
  )
)

(define (kind)
  (list 'Star)
)

(define (info? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ ( IKind IType ) #t ]
      [ else #f ]
    )
  )
)

(define (kind-info? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'IKind)
  )
)

(define (kind-info aKind)
  (list 'IKind aKind)
)

(define (kind-info-kind aKindInfo)
  (cadr aKindInfo)
)

(define (type-info? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'IType)
  )
)

(define (type-info aType)
  (list 'IType aType)
)

(define (type-info-type aTypeInfo)
  (cadr aTypeInfo)
)
