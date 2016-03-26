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
  cxt?
  empty-cxt?
  empty-cxt
  extend-cxt?
  extend-cxt
  extend-cxt-name
  extend-cxt-info
  extend-cxt-next
  get-info-cxt
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

(define (cxt? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ ( EmptyCxt ExtendCxt ) #t ]
      [ else #f ]
    )
  )
)

(define (empty-cxt? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'EmptyCxt)
  )
)

(define (empty-cxt)
  (list 'EmptyCxt)
)

(define (extend-cxt? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'ExtendCxt)
  )
)

(define (extend-cxt aName someInfo nextCxt)
  (list 'ExtendCxt aName someInfo nextCxt)
)

(define (extend-cxt-name anCxt)
  (cadr anCxt)
)

(define (extend-cxt-info anCxt)
  (caddr anCxt)
)

(define (extend-cxt-next anCxt)
  (cadddr anCxt)
)

(define (get-info-cxt anCxt aName)
  (if (list? anCxt)
    (case (car anCxt)
      [ ( ExtendCxt )
        (if (equal? (extend-cxt-name anCxt) aName)
          (extend-cxt-info anCxt)
          (get-info-cxt (extend-cxt-next anCxt) aName)
        )
      ] [ else null
      ]
    )
    null
  )
)
