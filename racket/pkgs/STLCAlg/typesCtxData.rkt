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
  ctx?
  empty-ctx?
  empty-ctx
  extend-ctx?
  extend-ctx
  extend-ctx-name
  extend-ctx-info
  extend-ctx-next
  get-info-ctx
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

(define (ctx? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ ( EmptyCtx ExtendCtx ) #t ]
      [ else #f ]
    )
  )
)

(define (empty-ctx? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'EmptyCtx)
  )
)

(define (empty-ctx)
  (list 'EmptyCtx)
)

(define (extend-ctx? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'ExtendCtx)
  )
)

(define (extend-ctx aName someInfo nextCtx)
  (list 'ExtendCtx aName someInfo nextCtx)
)

(define (extend-ctx-name anCtx)
  (cadr anCtx)
)

(define (extend-ctx-info anCtx)
  (caddr anCtx)
)

(define (extend-ctx-next anCtx)
  (cadddr anCtx)
)

(define (get-info-ctx anCtx aName)
  (if (list? anCtx)
    (case (car anCtx)
      [ ( ExtendCtx )
        (if (equal? (extend-ctx-name anCtx) aName)
          (extend-ctx-info anCtx)
          (get-info-ctx (extend-ctx-next anCtx) aName)
        )
      ] [ else null
      ]
    )
    null
  )
)
